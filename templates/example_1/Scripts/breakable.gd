class_name Breakable extends Node2D

var dropData = []
@export var hitCount = 5
@onready var currentHits = hitCount
@export var shakeX = 0.0
var sound = "res://Sounds/Sound Effects/mine_rock.wav"
var canBreak = true
@export var permanent = false
var playBreakSound = true

var hitBar = null
var hpReset = 0
var dropItems = true
var shakeDone = false
var hitByPlayer = false
@onready var mainSprite = $mainSprite

var repairTimer

@onready var isServer = multiplayer.is_server()

func get_custom_class(): return "Breakable"

func _ready():
	hitBar = load("res://Scenes/hit_bar.tscn").instantiate()
	add_child(hitBar,true)
	
	if permanent:
		remove_from_group("Save")
		canBreak = false
		
	repairTimer = Timer.new()
	add_child(repairTimer)
	repairTimer.timeout.connect(repair_hits)


func repair_hits():
	update_hits.rpc(hitCount,hitCount)


func _reset_lifespan():
	pass


@rpc("call_local")
func on_hit(changeDrop = true, hitStrength = 1, playerHit = false):
	hitByPlayer = playerHit
	shakeX = 5
	start_hit_shake()
	repairTimer.start(10.0)
	
	if multiplayer.is_server():
		_reset_lifespan()
		
		if canBreak:
			hpReset = 10
			update_hits.rpc(hitCount,currentHits-min(hitStrength, hitCount))
			
			if currentHits <= 0:
				dropItems = changeDrop
				_before_free.rpc()
				spawn_items()


@rpc("call_local","reliable")
func update_hits(newCount,newHits):
	hpReset = 10
	hitCount = newCount
	currentHits = newHits
	
	hitBar.max_value = hitCount
	hitBar.value = currentHits
	
	if hitCount == currentHits:
		hitBar.visible = false
	else:
		hitBar.visible = true
	

## Calls right before spawning items and being destroyed
@rpc("call_local")
func _before_free():
	var obj = load("res://Scenes/dust_particles.tscn").instantiate()
	obj.global_position = global_position
	get_parent().add_child(obj,true)


func spawn_items():
	var root = get_node("/root/Multiplayer")
	
	if get_node_or_null("inventory_component") != null:
		for item in $inventory_component.inventoryData:
			if item != null:
				item.Held = false
				dropData.push_back(item)
				
	_add_before_drop()
	
	if dropItems:
		for i in range(dropData.size()):
			var dropItem = dropData[i]
			root.create_item(dropItem, position, 50)
		
	queue_free()


func _add_before_drop():
	pass
	

func start_hit_shake():
	if shakeX > 0.1:
		mainSprite.skew = randf_range(deg_to_rad(clampf(-shakeX*2, -15.0, 0.0)),deg_to_rad(clampf(shakeX*2, 0.0, 15.0)))
		mainSprite.position.x = 0 + randf_range(-shakeX,shakeX)
		shakeX -= 15*get_process_delta_time()
		
		var timer = get_tree().create_timer(get_process_delta_time())
		timer.timeout.connect(start_hit_shake)
	else:
		shakeX = 0.0
		mainSprite.skew = 0
		mainSprite.position.x = 0
