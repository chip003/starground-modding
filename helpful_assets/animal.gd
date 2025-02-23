class_name Animal extends Entity

var interactItemID = ""
var interactItemAmount = 1

@export_group("Pathfinding")
@export_range(0.0, 90.0) var rayAngle = 30.0
@export_range(0.0,256.0) var rayLength = 16.0
@export var wanderTime = Vector2(1,10)
@export var wanderRange = Vector2(5,10)
@export var avoidObstacles = true
@export var leadFood : String = "" ## ID of food that will lead the animal

@export var isBaby : bool = true
var reproductionCooldown = 300.0
@export var reproductionReady = false
enum ReproductionTypes {NONE, ASEXUAL, SEXUAL}

@export_group("Stats")
@export var speed : float
@export var reproductionType : ReproductionTypes
@export var maturationTime : float = 60.0 ## How many seconds it takes for an animal to grow up
@export var hungerRate : float = 0.0 ## Time to consume 1 food in seconds

@export_group("Resources")
@export var ambienceSounds : Array[AudioStream] = []
@export var ambienceTime = Vector2(5,15)

@onready var leftRay : RayCast2D
@onready var rightRay : RayCast2D
@onready var raycasts : Node2D

var targetPos : Vector2

var running : bool = false

var direction = Vector2.ZERO
var pathingFrame = 0
var lastDir = 1
var moveVector = Vector2.ZERO

var hitTween

var wanderTimer : Timer = Timer.new()
var ambienceTimer : Timer = Timer.new()
var eatTimer : Timer = Timer.new()
var fleeTimer : Timer = Timer.new()

var fleeing = false
var reachedTarget = false

var starving = false

var starvationWarning
var notifier : VisibleOnScreenNotifier2D

var breedCheck : ShapeCast2D
var breedSearching = false

var heartParticles : CPUParticles2D

@rpc("call_local", "any_peer")
func set_physics_processing(status):
	if !status:
		#var closestPlayer = ModAPI.get_closest_player_target_and_dist(global_position)
		if notifier.is_on_screen():
			set_physics_processing.rpc(true)
		else:
			set_physics_process(false)
	else:
		set_physics_process(true)


func _ready() -> void:
	super()
	set_physics_process(false)
	
	interactItemID = leadFood
	
	notifier = VisibleOnScreenNotifier2D.new()
	add_child(notifier)
	notifier.screen_entered.connect(set_physics_processing.rpc.bind(true))
	notifier.screen_exited.connect(set_physics_processing.rpc.bind(false))
	fleeTimer.timeout.connect(func():fleeing = false)
	
	has_died.connect(func():
		_before_death()
		queue_free()
	)
	
	if avoidObstacles:
		leftRay = $Raycasts/Left
		rightRay = $Raycasts/Right
		raycasts = $Raycasts
		
		var angle = deg_to_rad(rayAngle)
		
		leftRay.target_position = Vector2(rayLength,0)
		rightRay.target_position = Vector2(rayLength,0)
		
		leftRay.target_position = leftRay.target_position.rotated(-angle)
		rightRay.target_position = rightRay.target_position.rotated(angle)
	
	if isServer:
		add_child(wanderTimer)
		wanderTimer.start(randf_range(wanderTime.x, wanderTime.y))
		wanderTimer.timeout.connect(pick_new_wander_target)
		
		add_child(fleeTimer)
		fleeTimer.autostart = false
		fleeTimer.one_shot = true
		
		breedCheck = ShapeCast2D.new()
		breedCheck.target_position = Vector2.ZERO
		breedCheck.shape = CircleShape2D.new()
		breedCheck.shape.radius = 256
		breedCheck.collision_mask = 4
		breedCheck.enabled = false
		add_child(breedCheck)
		
	set_growth(!isBaby, false)
	
	heartParticles = load("res://Resources/Effects/heart_particles.tscn").instantiate()
	heartParticles.emission_sphere_radius = 24
	heartParticles.emitting = false
	add_child(heartParticles)
	
	add_child(ambienceTimer)
	ambienceTimer.start(randf_range(ambienceTime.x, ambienceTime.y))
	ambienceTimer.timeout.connect(play_ambience)
	
	if hungerRate > 0:
		var newWarning = load("res://Scenes/building_warning.tscn").instantiate()
		newWarning.texture = load("res://Sprites/icon_starvation.png")
		add_child(newWarning)
		newWarning.name = "starvationWarning"
		starvationWarning = newWarning
		starvationWarning.position.y = -32
		
		if isServer:
			add_child(eatTimer)
			eatTimer.start(hungerRate)
			eatTimer.timeout.connect(try_eat)


func try_eat():
	for trough in get_tree().get_nodes_in_group("Trough"):
		if global_position.distance_squared_to(trough.global_position) <= 256*256:
			if trough.buildingInventory.remove_amount(leadFood, 1):
				starving = false
				starvationWarning.visible = false
				return
			
	if starving:
		has_died.emit()
		return

	starving = true
	starvationWarning.visible = true


@rpc("call_local")
func set_growth(growth, animate = true):
	isBaby = !growth
	reproductionReady = growth
	breedSearching = false
	
	var growthScale = 0.5 + int(growth)/2.0
	
	if animate:
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(mainSprite, "scale", Vector2(growthScale,growthScale), 2.0)
	else:
		mainSprite.scale = Vector2(growthScale, growthScale)


	if isServer && !growth:
		var timer = get_tree().create_timer(maturationTime)
		timer.timeout.connect(set_growth.rpc.bind(true))

	corpseScale = growthScale


func check_exclusive_interact() -> bool:
	return reproductionReady && !starving


@rpc("call_local","any_peer")
func exclusive_interact():
	if isServer:
		if !check_exclusive_interact():
			return
			
		if reproductionType == ReproductionTypes.NONE:
			return
			
		if starving:
			return
			
		var playerid = multiplayer.get_remote_sender_id()
		var playerInv = get_node_or_null("/root/Multiplayer/World/" + str(playerid) + "/inventory_component")

		if playerInv && playerInv.get_count(leadFood) > 0:
			playerInv.remove_amount(leadFood, 1)
		else:
			return
		
		if reproductionType == ReproductionTypes.ASEXUAL:
			var path = scene_file_path
			var child = load(path).instantiate()
			child.global_position = global_position
			get_parent().add_child(child,true)
			set_growth.rpc(false)
			breeding_effects.rpc(false,true)
		
		elif reproductionType == ReproductionTypes.SEXUAL:
			breeding_effects.rpc(true)
			
		reproductionReady = false
		var timer = get_tree().create_timer(reproductionCooldown)
		timer.timeout.connect(func():
			breeding_effects.rpc(false)
			reproductionReady=true
		)


@rpc("call_local")
func breeding_effects(status, noise = false):
	breedSearching = status
	heartParticles.emitting = status
	if noise:
		var player = load("res://Scenes/ding_sound.tscn").instantiate()
		player.global_position = global_position
		add_child(player)


func play_ambience():
	if ambienceSounds.size() > 0:
		$Ambience.stream = ambienceSounds.pick_random()
		$Ambience.pitch_scale = randf_range(0.8,1.2) * int(isBaby) + 1
		$Ambience.play()
		
	ambienceTimer.start(randf_range(ambienceTime.x, ambienceTime.y))


func _physics_process(delta: float) -> void:
	if !isServer:
		velocity = velocitySync
		move_and_slide()
		return
	
	if !leadFood.is_empty():
		var closestPlayer = ModAPI.get_closest_player_target(global_position)
		if closestPlayer:
			var heldItem = closestPlayer.heldItems[closestPlayer.selectedTool]
			if heldItem == leadFood:
				if global_position.distance_squared_to(closestPlayer.global_position) < 256*256 && closestPlayer.selectedTool >= 2:
					targetPos = closestPlayer.global_position
	
	if breedSearching:
		breedCheck.force_shapecast_update()
		for i in breedCheck.get_collision_count():
			var obj = breedCheck.get_collider(i)
			if obj.scene_file_path == scene_file_path && obj.breedSearching:
				targetPos = obj.global_position
				if global_position.distance_squared_to(obj.global_position) < 6*6:
					breeding_effects.rpc(false,true)
					obj.breeding_effects.rpc(false,true)
					
					var path = scene_file_path
					var child = load(path).instantiate()
					child.global_position = global_position
					get_parent().add_child(child,true)
	
	if targetPos && pathingFrame <= 0:
		if avoidObstacles:
			leftRay.force_raycast_update()
			rightRay.force_raycast_update()
			
			raycasts.rotation = global_position.direction_to(targetPos).angle()
			if leftRay.is_colliding() && rightRay.is_colliding():
				direction = global_position.direction_to(targetPos).rotated(PI/2*lastDir)
			elif leftRay.is_colliding():
				direction = global_position.direction_to(raycasts.to_global(rightRay.target_position))
				lastDir = 1
			elif rightRay.is_colliding():
				direction = global_position.direction_to(raycasts.to_global(leftRay.target_position))
				lastDir = -1
			else:
				direction = global_position.direction_to(targetPos)
		else:
			direction = global_position.direction_to(targetPos)
		
		if global_position.distance_to(targetPos) < 5:
			direction = Vector2.ZERO
			reachedTarget = true
		else:
			reachedTarget = false
			
		pathingFrame = 10
	
	var modifier = 1.0
	
	if fleeing:
		modifier = 2.0
	
	$mainSprite.speed_scale = modifier
	velocity = direction*(speed*modifier)
	pathingFrame -= 1
	move_and_slide()


func pick_new_wander_target():
	var dist = Vector2(randf_range(wanderRange.x, wanderRange.y),0)*16
	targetPos = global_position + dist.rotated(randf_range(-PI,PI))
	
	var regionOffset = ModAPI.get_region_at_position(global_position).Location
	
	var bound = ((Global.generationInfo.Size/2.0)+8)*16
	
	targetPos = targetPos.clamp(Vector2(-bound+regionOffset.x, -bound+regionOffset.y), Vector2(bound+regionOffset.x, bound+regionOffset.y)) #-((Global.generationInfo.Size/2.0)+8)*16+regionOffset, ((Global.generationInfo.Size/2.0)+8)*16+regionOffset)

	if fleeing:
		wanderTimer.start(randf_range(wanderTime.x, wanderTime.y)/2.0)
	else:
		wanderTimer.start(randf_range(wanderTime.x, wanderTime.y))


func set_flee_time(fleeTime):
	if fleeTimer.is_stopped():
		fleeTimer.start(fleeTime)
	else:
		fleeTimer.wait_time = fleeTime
	fleeing = true


func _on_hit():
	if isServer:
		set_flee_time(5.0)
		pick_new_wander_target()
	
	$mainSprite.modulate = Color(5.0,5.0,5.0,1.0)
	
	shakeX = 1.0
	
	if hitTween:
		hitTween.kill()
		
	hitTween = get_tree().create_tween()
	hitTween.set_ease(Tween.EASE_OUT)
	hitTween.set_trans(Tween.TRANS_QUAD)
	hitTween.tween_property($mainSprite, "modulate", Color(1.0,1.0,1.0,1.0), 0.25)
	
	var part = get_node_or_null("HitParticles")
	
	if part:
		part.restart()
		part.emitting = true
