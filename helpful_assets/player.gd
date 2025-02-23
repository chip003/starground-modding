class_name Player extends Entity

## Stats ---------------------------------
var setPickupRadius = 32.0 # Base range that items can be picked up from
var pickupRadius = setPickupRadius

var setMiningRange = 128.0 # Base range that things can be mined
var miningRange = setMiningRange

var speed = 1600
var maxSpeed = 150

var setLightScale = 0.1 # The modifier for the surrounding point light

var miningTime = 0.5 # Base time (seconds) between mining
var miningTimer = 0 # Current mining timer
var miningOffset = Vector2.ZERO

var setInteractRange = 128.0
var interactRange = setInteractRange

var foodCooldown = 15.0
var currentFoodCooldown = 0.0

#----------------------------------

signal rolled
signal dismount

var footstepGrass = [
	load("res://Sounds/Sound Effects/step_grass.wav")
]

var footstepMetal = [
	load("res://Sounds/Sound Effects/step_metal.wav")
]

var interactHover = false
var direction = 1
var conveyorsMove = true
#var closest = null
@export var username = ""
var hasStepped = true
@export var isMining = false
@export var miningTargetPos = Vector2(0,0)

var uiOpen = false

var rollStarted = false
var laserProgress = 0.0
@export var currentVelocity = Vector2.ZERO
@export var weaponReference : Node2D
var lookDirection = Vector2(1,0)

var zoomLimit = true # Whether or not zooming has a limit

@onready var inventory = $inventory_component

var inVehicle = false

var escapePod

var velocityOffset = Vector2.ZERO
var moveVelocity = Vector2.ZERO
var rollVelocity = Vector2.ZERO

##stuff for launching
var lastSelectedTool = 0
var starlauncher = null
var starlauncherTP = Vector2.ZERO
var starlauncherFinished = false
var newRegion = null

var buildingOffset = Vector2.ZERO

var numHotbarSlots = 6

var bossActive = false
@export var inDungeon = false
var sentOpenRequest = false

var targetZoom = Vector2(3,3)
var hitZoom = Vector2(0,0)
@export var cameraShake = 0.0
var activeCameraShake = Vector2.ZERO

var openPosition = Vector2(0,0)
var hasOpenedObject = false
var menuOpen = false

var swingAngle = 150

var lastMoveDirection = Vector2.RIGHT
var rollStrength = 700
var rollCooldown = 2.0
var currentRollCooldown = rollCooldown

## UI related
var cutsceneLock = false
var canInteract = true
var movementLock = false


## FISHING
@export var castDist = 0.0
var maxCastDist = 96
var hitMaxCast = false
var bitFish : Node2D
var fishingGameActive = false
var bobberReturned = false
var chargeTween
#var caughtItemID : String
var targetFish
var bobberReady = false
var holdingFish = false

var effectNodes : Dictionary = {}

## Array of held item dictionaries
@export var heldItems = []

@onready var healthBar = $Canvas/HealthDisplay/VBoxContainer/HBoxContainer/VBoxContainer/Health
@onready var debugLabel = $Canvas/DebugOverlay/debugLabel
@onready var dayLabel = $Canvas/HealthDisplay/VBoxContainer/HBoxContainer2/MarginContainer/MarginContainer/Day
@onready var dayIcon = $Canvas/HealthDisplay/VBoxContainer/HBoxContainer2/MarginContainer/TimeIcon
@onready var healthBarTexture = $Canvas/HealthDisplay/VBoxContainer/HBoxContainer/VBoxContainer/Health/MarginContainer/NinePatchRect
@onready var playerHand = $Hand
@onready var playerLaser = $Laser

var steamID : int = 0

## Weapon Variables
var weaponDamage = 0.25
var weaponCooldown = 0.25
var specialWeaponCooldown = 0.0
var currentSpecialWeaponCooldown = 0.0
var weaponKnockback = 0
var weaponHeight = 0
var bladeWidth = 0
var selfDamage = 0
var lastWeaponData = []
@export var selectedTool = -1
@export var subSelectedTool = 0
var currentComboHit = 0
var canCombo = false
var currentComboTimer = 0.0
var comboActive = false
var swingDir = 0
var weaponDelay = 0 #time that movement is stopped for after attacking
var currentWeaponDelay = 0
@export var weaponRotationOffset = 0.0
@onready var cooldownStar = $"Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/1/MarginContainer2/CooldownStar"
var weaponHandOffset = -6.0

var recharged = true # whether or not a regular weapon is recharged
var specialRecharged = true # whether or not a special component is recharged
#------------------------------------

@export var isVisible = false

var dropDelay = 1
#var startOpen = false

var spawnDelay = false
var deathStart = true

var lastHoveredObject
var chatSelected = false
@export var displayName = false

@export var slashSounds = []

@onready var main = get_node("/root/Multiplayer")
@onready var lightingNode = get_node("/root/Multiplayer/Lighting")

@rpc("call_local","any_peer", "reliable")
func sync_tool():
	if isAuthority:
		set_weapon.rpc()
		if selectedTool == -1:
			change_tool.rpc(0, true, subSelectedTool)
		else:
			change_tool.rpc(selectedTool, true, subSelectedTool)


func _enter_tree():
	set_multiplayer_authority(name.to_int(), true)
	if is_multiplayer_authority():
		Global.multiplayerID = name.to_int()
		Global.activePlayer = self


func _ready():
	super._ready()
	
	if Global.foundConvertFormat < 1:
		for i in range(heldItems.size()):
			if heldItems[i] != null:
				heldItems[i] = Global.convert_name(heldItems[i])
		
		if heldItems.size() == 6:
			for i in range(2,6):
				get_node("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/" + str(i)).activate(heldItems[i])
	
	heldItems.resize(numHotbarSlots)
	
	$RollProgress.visible = false
	
	if isAuthority:
		Global.set_region("starground:region_veridian")
		Global.set_level(0)
		username = Global.username
		$Camera.enabled = true
		$Canvas.visible = true
		$Camera.make_current()
		Global.fully_loaded.connect(start_first_pod)
		global_position = Vector2(0,0)
		if username != "":
			main.send_chatbox_message.rpc(username, "[color=#FEE761] " + tr("has joined the game") + "[/color]", false)
	else:
		$Canvas.visible = false
		
	set_weapon.rpc()
	sync_tool.rpc()
	
	toggle_visibility(false)


func start_first_pod():
	start_pod.rpc()
	

func drop_inventory():
	for i in inventory.inventoryData:
		if i != null:
			main.create_item(i, Vector2(0,0), 5)
		
	for i in $weapon_configuration.inventoryData:
		if i != null:
			main.create_item(i, Vector2(0,0), 5)


@rpc("call_local", "unreliable_ordered")
func play_animation(string, reversed = false):
	if mainSprite.animation != string:
		if reversed:
			mainSprite.play_backwards(string)
		else:
			mainSprite.play(string)


@rpc("call_local","any_peer")
func mine_sound(sound):
	$Mine.stream = load(sound)
	$Mine.pitch_scale = randf_range(0.75,1.25)
	$Mine.play()


@rpc("any_peer", "call_local")
func mine(pos): #server side only
	#print("i be mining")
	var overlaps = $MiningTarget/Area2D.get_overlapping_bodies()
	var closest = null
	
	var dist = 99999

	for i in overlaps:
		if i != null:
			if pos.distance_to(i.position) < dist:
				dist = pos.distance_to(i.position)
				closest = i
	
	if closest != null:
		if closest is Breakable:
			closest.on_hit.rpc(true,1,true)
			if closest.playBreakSound:
				mine_sound.rpc(closest.sound)


@rpc("call_local", "any_peer", "reliable")
func set_weapon():
	lastWeaponData = $weapon_configuration.inventoryData.duplicate(true)
	weaponDamage = 0.0
	weaponCooldown = 0.25
	specialWeaponCooldown = 0.0
	weaponKnockback = 0
	weaponDelay = 0
	weaponHeight = 0
	bladeWidth = 0
	selfDamage = 0
	var firstPiece = true
	
	#var newWeaponDamage = 0.0
	
	var weaponData = [{},{},{},{}]
	
	var sprites = ["Handle", "Handguard", "Blade"]
	var currentPos = 0.0
	
	$Hand/Weapon/Hand.position.y = -6
	
	for i in range($weapon_configuration.inventoryData.size()):
		var part = $weapon_configuration.inventoryData[i]
		var node = get_node("Hand/Weapon/" + sprites[i])
		if part:
			node.position.y = currentPos
			node.texture = ModAPI.get_item_data(part.ID).Sprite
			weaponHeight += node.texture.get_height()
			bladeWidth = node.texture.get_height()
			node.offset.y = -node.texture.get_height()/2.0
			currentPos -= node.texture.get_height()
				
			var itemData = ModAPI.get_item_data(part.ID)
			if itemData:
				if itemData.get("SpecialWeapon",false): ## Special component
					if itemData.has("Cooldown"):
						specialWeaponCooldown += itemData.Cooldown
				else: ## Normal melee component
					if itemData.has("Damage"):
						if firstPiece:
							if itemData.has("SelfDamage"):
								selfDamage += itemData.Damage
							
						weaponDamage += itemData.Damage
						
					if itemData.has("Cooldown"):
						weaponCooldown += itemData.Cooldown
					else:
						weaponCooldown += 0.5
							
					if itemData.has("Knockback"):
						weaponKnockback += itemData.Knockback
					
				weaponData[i].Name = itemData.Name
				weaponData[i].Damage = weaponDamage
				weaponData[i].Cooldown = weaponCooldown
				weaponData[i].Knockback = weaponKnockback
				
			if firstPiece:
				firstPiece = false
				node.flip_v = true
				weaponHandOffset = -node.texture.get_height()/2.0
				$Hand/Weapon/Hand.position.y = weaponHandOffset
			else:
				node.flip_v = false
		else:
			get_node("Hand/Weapon/" + sprites[i]).texture = null
		
	weaponCooldown = clampf(weaponCooldown, 0.2, INF)
	weaponDamage = clampf(weaponDamage, 0.5, INF)
	weaponKnockback = clampf(weaponKnockback, 0, INF)
	weaponDelay = weaponCooldown/3.0
	
	get_node("Hand/Weapon/Recharge").position.y = -weaponHeight
	get_node("Hand/Weapon/SpecialRecharge").position.y = -weaponHeight
	
	if selectedTool == 1:
		damage = weaponDamage
		cooldown = weaponCooldown
	
	weaponData[3].Cooldown = weaponCooldown
	weaponData[3].Damage = weaponDamage
	weaponData[3].Knockback = weaponKnockback
	weaponData[3].Reach = snappedf(weaponHeight/16.0, 0.1)
	
	get_tree().call_group("WeaponUI","update_text",weaponData)
	
	if isAuthority:
		##update tool in hotbar
		var totalSpriteHeight = 0.0
		
		var hasSprite = false
		
		for i in range($weapon_configuration.inventoryData.size()):
			if $weapon_configuration.inventoryData[i] != null:
				totalSpriteHeight += ModAPI.get_item_data($weapon_configuration.inventoryData[i].ID).Sprite.get_height()
		
		for i in range($weapon_configuration.inventoryData.size()):
			var partTexture = get_node("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/1/MarginContainer/VBoxContainer/" + str(i))
			
			if $weapon_configuration.inventoryData[i] != null:
				partTexture.texture = ModAPI.get_item_data($weapon_configuration.inventoryData[i].ID).Sprite
				partTexture.size_flags_stretch_ratio = float(partTexture.texture.get_height())/totalSpriteHeight
				hasSprite = true
			else:
				partTexture.size_flags_stretch_ratio = 0.0
				partTexture.texture = null
				
		if !hasSprite:
			get_node("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/1/MarginContainer/VBoxContainer/1").size_flags_stretch_ratio = 1.0
			get_node("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/1/MarginContainer/VBoxContainer/1").texture = load("res://Sprites/fist.png")


@rpc("any_peer", "call_local")
func create_attack_box(attackDamage, attackKnockback, _pos):
	var box = load("res://Scenes/attack_box.tscn").instantiate()
	box.global_position = global_position
	box.damage = attackDamage
	box.scale = Vector2(1,1)*max(weaponHeight,24)
	box.knockback = attackKnockback*10
	box.rotation = $Laser.global_position.angle_to_point(miningTargetPos)
	get_parent().add_child(box,true)


@rpc("call_local","any_peer")
func tool_action(delta, swingCount = 0):
	if selectedTool == 0:
		currentCooldown = cooldown
		if isAuthority:
			if miningTimer <= 0:
				mine.rpc_id(1,$MiningTarget.global_position)
				var laserInfo = main.researchInfo.get("starground:research_mining_laser_power", null)
				if laserInfo:
					miningTimer = miningTime/(1+(laserInfo.Level*Global.researchTable["starground:research_mining_laser_power"].EffectIncrement))
				else:
					miningTimer = miningTime
			else:
				miningTimer -= 1*delta
			
	elif selectedTool == 1:
		currentCooldown = cooldown
		$WeaponController.stop()
		if swingCount % 2 == 1:
			$WeaponController.play("SwingForward")
		else:
			$WeaponController.play("SwingBack")
		$WeaponController.speed_scale = 1/cooldown

		var slash = load("res://Scenes/effect_slash.tscn").instantiate()

		slash.rotation = $Hand.rotation
		slash.position = global_position
		slash.scale *= (weaponHeight)/32.0
		slash.dissolveSpeed = cooldown/2
		get_parent().add_child(slash,true)
		
		currentWeaponDelay = weaponDelay
		
		mainSprite.scale.y = 0.75
		hitZoom += Vector2(0.1,0.1)*Global.screenshake
		$Camera.position = global_position.direction_to($Cursor.global_position)*10*Global.screenshake
		
		$Attack.stream = slashSounds.pick_random()
		$Attack.pitch_scale = clampf(1/(cooldown/2.0),0.5,2.5)
	
		$Attack.play()
		recharged = false
		
		if isAuthority:
			var attackDir = global_position.direction_to($Cursor.global_position)
			create_attack_box.rpc_id(1, damage*attackDamageModifier, attackDir*weaponKnockback, global_position+(attackDir*weaponHeight))
			
			#deal damage to self if handle deals damage
			if selfDamage > 0 && inventory.get_count("starground:chainmail_glove") == 0:
				take_damage.rpc(selfDamage,Vector2.ZERO)
	else:
		if isAuthority:
			var count = inventory.get_count(heldItems[selectedTool])
			if count > 0:
				consume_item.rpc(heldItems[selectedTool], count)


@rpc("call_local","reliable")
func consume_item(itemID, count):
	var itemInfo = ModAPI.get_item_data(itemID)
	var consumed = false
	var eaten = false
	
	if itemID == "starground:bomb":
		consumed = true
		if isServer:
			var bomb = load("res://Scenes/bomb.tscn").instantiate()
			bomb.global_position = global_position
			get_parent().add_child(bomb,true)
			
	if itemID == "starground:nuclear_bomb":
		consumed = true
		if isServer:
			var bomb = load("res://Scenes/nuclear_bomb.tscn").instantiate()
			bomb.global_position = global_position
			get_parent().add_child(bomb,true)
	
	var healAmount = itemInfo.get("Heal", 0)
	if healAmount > 0 && currentFoodCooldown <= 0:
		consumed = true
		eaten = true
		currentHP += clampf(healAmount, 0.0, hp-currentHP)
	
	var itemEffects = itemInfo.get("Effects")
	if itemEffects && currentFoodCooldown <= 0:
		for effect in itemEffects:
			apply_effect(effect.ID, effect.Length)
			consumed = true
			eaten = true
	
	var spawnScene = itemInfo.get("SpawnScene")
	if spawnScene:
		consumed = true
		$EggCrack.pitch_scale = randf_range(0.75,1.25)
		$EggCrack.play()
		get_tree().call_group("Tutorial", "play_tooltip", "KEY_TUTORIAL_ANIMALS")
		if isServer:
			var obj = load(spawnScene).instantiate()
			obj.global_position = global_position
			get_parent().add_child(obj, true)
	
	if eaten:
		$EatFood.pitch_scale = randf_range(0.75,1.25)
		$EatFood.play()
		currentFoodCooldown = foodCooldown
		
	if consumed:
		item_effect()
		
		if isServer:
			inventory.remove_amount(itemID,1)
			
		if isAuthority:
			if count <= 1:
				$Hand/Weapon/Hand/Item.texture = null


func item_effect():
	currentCooldown = cooldown
	$WeaponController.play("SwingForward")


func start_blinded():
	$Flash/ColorRect.visible = true
	$Flash/ColorRect.modulate.a = 0.75


@rpc("call_local")
func inventory_check(path):
	var object = get_node_or_null(path)
	
	if object != null:
		if object.is_in_group("Inventories"):
			var component = object.buildingInventory
			$Canvas/ui_inventory.add_inventory(component)
			open_inventory.rpc(component.showPlayerInventory, true, component.get_parent().global_position)


@rpc("call_local","any_peer", "reliable")
func open_inventory(playerInventoryVisible = true, openedObject = false, openPos = global_position):
	if isAuthority:
		var playerInventory = get_node("Canvas/ui_inventory/inventoryGrids/" + name + "_inv")
		var buildingInventory = get_node("Canvas/InventoryDisplayBuilding")
		var researchInventory = get_node("Canvas/ResearchMenu")
		
		if openedObject:
			openPosition = openPos
			hasOpenedObject = true
		
		if playerInventoryVisible:
			playerInventory.visible = true
		else:
			playerInventory.visible = false
			
		buildingInventory.visible = false
		researchInventory.visible = false
		
		close_pause()
			
		await get_tree().process_frame
			
		$Canvas/ui_inventory.visible = true


func close_inventory():
	if isAuthority:
		var playerInventory = get_node("Canvas/ui_inventory/inventoryGrids/" + name + "_inv")
		
		$Canvas/ui_inventory/ItemPreview.close.rpc_id(1)
		$Canvas/ui_inventory.visible = false
		playerInventory.visible = false
		hasOpenedObject = false
		canMove = true
	

func open_pause(guidepage = false):
	if !$Canvas/PauseMenu.visible:
		$Canvas/PauseMenu.visible = true
		canInteract = false
		canMove = false
		
		if guidepage:
			$Canvas/PauseMenu.open_guide(0)


func close_pause():
	if $Canvas/PauseMenu.visible:
		$Canvas/PauseMenu.visible = false
		canInteract = true
		canMove = true
		
		
func toggle_pause():
	if $Canvas/PauseMenu.visible:
		close_pause()
	else:
		open_pause()


func _on_hit():
	$mainSprite/Hit.modulate.a = 1
	$CPUParticles2D.restart()
	$CPUParticles2D.emitting = true
	hitZoom += Vector2(0.3,0.3)*Global.screenshake
	mainSprite.scale.y = 0.5


@rpc("call_local", "any_peer")
func change_tool(newSelection = 0, force = false, newSubIndex = subSelectedTool):
	var children = $Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer.get_children()
	
	if newSelection != selectedTool || force:
		cancel_fishing()
		selectedTool = newSelection
		subSelectedTool = newSubIndex
		$Laser.visible = false
		$Hand/Weapon.visible = false
		$Hand/Weapon/Hand/Item.texture = null
		
		if selectedTool == 0:
			$Laser.visible = true
			
			var imageSlot
			
			if isAuthority:
				imageSlot = get_node("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/0/MarginContainer/TextureRect")
			
			if subSelectedTool == 0:
				$Laser/MiningHand.visible = true
				$Laser/ShovelHand.visible = false
				$Laser/FishingHand.visible = false
				if isAuthority:
					imageSlot.texture = load("res://Sprites/mining_laser.png")
			elif subSelectedTool == 1:
				$Laser/MiningHand.visible = false
				$Laser/ShovelHand.visible = true
				$Laser/FishingHand.visible = false
				if isAuthority:
					imageSlot.texture = load("res://Sprites/shovel.png")
			else:
				$Laser/MiningHand.visible = false
				$Laser/ShovelHand.visible = false
				$Laser/FishingHand.visible = true
				if isAuthority:
					imageSlot.texture = load("res://Sprites/fishing_rod.png")
			
			damage = 1
			cooldown = 0
			currentCooldown = 0
			recharged = true
		elif selectedTool == 1:
			$Hand/Weapon/Hand.position.y = weaponHandOffset
			$Hand/Weapon.visible = true
			damage = weaponDamage
			cooldown = weaponCooldown
			currentCooldown = cooldown
			weaponRotationOffset = deg_to_rad(swingAngle)
			recharged = false
			$Hand/Weapon/Handle.visible = true
			$Hand/Weapon/Handguard.visible = true
			$Hand/Weapon/Blade.visible = true
		elif selectedTool > 1:
			$Hand/Weapon/Hand.position.y = -6
			$Hand/Weapon.visible = true
			damage = 0
			cooldown = 1
			currentCooldown = 0
			recharged = true
			if heldItems[selectedTool] != null:
				if inventory.get_count(heldItems[selectedTool]) > 0:
					$Hand/Weapon/Hand/Item.texture = ModAPI.get_item_data(heldItems[selectedTool]).Sprite
			$Hand/Weapon/Handle.visible = false
			$Hand/Weapon/Handguard.visible = false
			$Hand/Weapon/Blade.visible = false
			
	for child in children:
		if child is TextureRect:
			if child.name == str(selectedTool):
				child.custom_minimum_size = Vector2(72,72)
				child.texture = load("res://Sprites/slot_frame_highlighted.png")
			elif child.name.is_valid_int():
				child.custom_minimum_size = Vector2(64,64)
				child.texture = load("res://Sprites/slot_frame.png")


@rpc("call_local", "reliable")
func start_pod(newPos = global_position):
	set_collision_mask_value(1,true)
	var pod = load("res://escape_pod.tscn").instantiate()
	get_parent().add_child(pod)
	pod.global_position = newPos
	escapePod = pod
	
	if isAuthority:
		cutsceneLock = true
		pod.finished.connect(exit_pod.rpc)


@rpc("call_local")
func exit_pod():
	if is_instance_valid(escapePod):
		escapePod.open_pod()
		if isAuthority:
			toggle_visibility(true)
			cutsceneLock = false
		
	
func start_launch(regionID, launcherReference):
	close_inventory()
	cutsceneLock = true
	
	set_collision_mask_value(1,false)
	starlauncher = get_node_or_null(launcherReference)
	starlauncher.finished.connect(on_starlauncher_finished)
	$Canvas/Minimap.currentRoom = Vector2.ZERO
	
	var regionData = Global.regionsTable.get(regionID)
	starlauncherTP = regionData.Location + regionData.SpawnOffset
	newRegion = regionID
	dismount.emit()


func toggle_visibility(status):
	visible = status
	

## runs on client
func on_starlauncher_finished():
	Global.set_region(newRegion)
	Global.set_level(0)
	
	if Global.is_in_dungeon():
		main.create_dungeon.rpc_id(1, Global.currentRegion, starlauncherTP, 0)
		get_tree().call_group("Tutorial", "play_tooltip", "KEY_TUTORIAL_DUNGEON")
	
	global_position = starlauncherTP
	$Camera.reset_smoothing()
	starlauncher.finished.disconnect(on_starlauncher_finished)
	
	starlauncher = null
	starlauncherFinished = false
	
	start_pod.rpc(global_position)
	Global.stop_music(1)


@rpc("call_local")
func respawn():
	knockback = Vector2.ZERO
	hasDied = false
	deathStart = true
	currentHP = hp
	toggle_visibility(false)
	
	if isAuthority:
		global_position = Vector2(0,0)
		$Camera.reset_smoothing()
		Global.set_region("starground:region_veridian")
		Global.set_level(0)
		Global.stop_music(1)
		
	start_pod.rpc(global_position)
		

## SERVER ONLY
func lose_items():
	var lostItems = []
	for i in range(inventory.inventoryData.size()):
		if inventory.inventoryData[i] != null:
			var chance = randf_range(0.0,100.0)
			if chance <= 20.0:
				var lostAmount = randi_range(1,ceil(inventory.inventoryData[i].Amount/2.0))
				
				var lostItem = {
					"ID": inventory.inventoryData[i].ID,
					"Amount": lostAmount
				}
				
				lostItems.push_back(lostItem)
				if lostAmount < inventory.inventoryData[i].Amount:
					inventory.inventoryData[i].Amount -= lostAmount
				else:
					inventory.inventoryData[i] = null
	
	death_results.rpc_id(get_multiplayer_authority(), lostItems)


@rpc("any_peer", "call_local", "reliable", 0)
func death_results(lostItems):
	if isAuthority:
		$Canvas/DeathScreen.initialize(lostItems)
	
	
@rpc("call_local","any_peer","reliable")
func death_init():
	if isAuthority:
		close_inventory()
		$PositionIndependent/BuildPreview.visible = false
		
	cutsceneLock = true
	hasDied = true
	play_animation("death")
	$Death.play()
	
	
func item_mine_check(pos):
	var overlaps = $MiningTarget/Area2D.get_overlapping_bodies()
	var closest = null
	
	var dist = INF

	for i in overlaps:
		if i != null:
			if pos.distance_to(i.position) < dist:
				dist = pos.distance_to(i.position)
				closest = i
	
	if closest is Item:
		closest.force_pick_up(self)
	
	
@rpc("call_local","any_peer", "reliable")
func change_held_item(visibility):
	$Hand/Weapon/Hand/Item.visible = visibility
	
	
func check_floor():
	if Global.currentRegionID == "starground:region_tyria":
		var tilemap : TileMapLayer = Global.currentTilemap
		
		if tilemap:
			var data = tilemap.get_cell_atlas_coords(tilemap.local_to_map(tilemap.to_local(global_position)))
			
			if data.x < 3 && data.y > 7:
				if Global.playerIsUnderwater:
					Global.toggle_underwater(false, true)
					$Splash.pitch_scale = randf_range(0.75,1.25)
					$Splash.play()
					
					$Canvas/WaterLeft/CPUParticles2D.restart()
					$Canvas/WaterRight/CPUParticles2D.restart()
					
					$Canvas/WaterLeft/CPUParticles2D.emitting = true
					$Canvas/WaterRight/CPUParticles2D.emitting = true
					
					$Step.stream = footstepMetal.pick_random()
					#print("haha")
					
			elif !Global.playerIsUnderwater:
				Global.toggle_underwater(true, true)
				$Splash.pitch_scale = randf_range(0.75,1.25)
				$Splash.play()
				
				$Step.stream = footstepGrass.pick_random()
				
				$Canvas/WaterLeft/CPUParticles2D.restart()
				$Canvas/WaterRight/CPUParticles2D.restart()
				
				$Canvas/WaterLeft/CPUParticles2D.emitting = true
				$Canvas/WaterRight/CPUParticles2D.emitting = true
	else:
		if footstepMetal.has($Step.stream):
			$Step.stream = footstepGrass.pick_random()
	
	
func check_boss_music():
	var closestBoss = ModAPI.get_closest_node(global_position,"Boss")
	if closestBoss && global_position.distance_to(closestBoss.global_position) < 460 && !closestBoss.hasDied:
		if !bossActive:
			$Canvas/TopBar.visible = true
			bossActive = true
			Global.only_stop_music(0.5)
			if closestBoss is DreadcapBoss:
				Global.set_music_override(load("res://Sounds/Music/dreadcap_boss.ogg"))
			elif closestBoss is SporeBoss:
				Global.set_music_override(load("res://Sounds/Music/spore_boss.ogg"))
			$Canvas/TopBar/VBoxContainer/Label.text = closestBoss.bossName
			
		$Canvas/TopBar/VBoxContainer/HBoxContainer/BossHealth.max_value = closestBoss.hp
		$Canvas/TopBar/VBoxContainer/HBoxContainer/BossHealth.value = closestBoss.currentHP

	else:
		if bossActive:
			bossActive = false
			$Canvas/TopBar.visible = false
			Global.set_music_override(null)
			Global.only_stop_music(0.5)
		
		bossActive = false
	
	
func process_server_checks():
	if isMining:
		item_mine_check($MiningTarget.global_position)
		
	if !inDungeon:
		currentHP = hp
		
	#if get_multiplayer_authority() != 1:
		#var peers = multiplayer.get_peers()
		#if !peers.has(get_multiplayer_authority()):
			#if dropDelay == 1:
				#dropDelay -= 1
			#else:
				#if username != "":
					#main.send_chatbox_message.rpc(username, "[color=#FEE761] has left the game[/color]", false)
					#
				#if steamID != 0:
					#drop_inventory()
					#main.localPlayers.erase(name.to_int())
				#else:
					#var dat = get_node("save_component").save_dict()
					#main.steamPlayers[steamID] = dat
					#
				#queue_free()
				
	if hasDied:
		if deathStart:
			deathStart = false
			death_init.rpc()
			var timer = get_tree().create_timer(2.0)
			timer.timeout.connect(lose_items)
	
	
func remove_effect(effectID):
	super(effectID)
	if effectNodes.has(effectID):
		effectNodes[effectID].queue_free()
		effectNodes.erase(effectID)
	
	
func _process(delta):
	if isAuthority:
		for i in currentEffects:
			var effectStatus = currentEffects.get(i)
			var effectNode = effectNodes.get(i)
			var effectInfo = Global.effectsTable.get(i)
			
			if !effectNode:
				var effect = load("res://Scenes/effect_indicator.tscn").instantiate()
				effect.texture.texture = effectInfo.Sprite
				effect.tooltip_text = effectInfo.Name
				effectNodes[i] = effect
				$Canvas/HealthDisplay/VBoxContainer/Effects.add_child(effect)
			else:
				if effectStatus.Time-1*delta <= 0:
					effectNodes.erase(i)
					effectNode.queue_free()
				else:
					effectNode.label.text = str(snappedf(effectStatus.Time, 0.1))
				
	super(delta)
	
	$mainSprite/Helmet.visible = Global.playerIsUnderwater
	mainSprite.speed_scale = speedModifier*speedVehicleModifier*speedEffectModifier*speedCommandModifier
	$Name.visible = !Global.hidePlayerNames && !$FishingHands.visible
	$mainSprite/Helmet.flip_h = mainSprite.flip_h

	## Server code
	if isServer:
		process_server_checks()
		
	if $PositionIndependent/Bobber.visible:
		$PositionIndependent/FishingLine.points = [$Laser/FishingHand/LineAnchor.global_position, $PositionIndependent/Bobber.global_position]
	else:
		$PositionIndependent/FishingLine.points = []
		
	$Name/Username.text = username
	$MiningTarget.global_position = position+((miningTargetPos-position).limit_length(miningRange))
	mainSprite.scale = mainSprite.scale.lerp(Vector2(1,1), 1 - pow(0.005, delta))
	
	### Weapon tool rotation
	var rot = $Laser.global_position.angle_to_point(miningTargetPos)

	if lightingNode.color.get_luminance() > 0.6:
		if $Laser/Flashlight.visible:
			$FlashlightClick.pitch_scale = randf_range(0.75,1.25)
			$FlashlightClick.play()
			$SurroundingLight.visible = false
			$Laser/Flashlight.visible = false
	else:
		if !$Laser/Flashlight.visible:
			$FlashlightClick.pitch_scale = randf_range(0.75,1.25)
			$FlashlightClick.play()
			$SurroundingLight.visible = true
			$Laser/Flashlight.visible = true
	
	if !rollStarted:
		if abs(rot) < PI/2:
			direction = 1
		else:
			direction = -1
		
	$Hand.rotation = rot
	
	var rotOffset = 0
	if selectedTool != 1:
		if abs($Hand.rotation) < PI/2.0:
			rotOffset = PI/2.0
		else:
			rotOffset = -PI/2.0
		
	if abs($Hand.rotation) > PI/2.0:
		weaponReference.scale.x = -1
		weaponReference.rotation = (deg_to_rad(weaponRotationOffset)*direction)+PI+rotOffset
	else:
		weaponReference.scale.x = 1
		weaponReference.rotation = deg_to_rad(weaponRotationOffset)*direction+rotOffset
			
	$Laser/Beam.size.x = abs($Laser.global_position.distance_to($MiningTarget.global_position))-$Laser/Beam.position.x

	if !fishingGameActive:
		$Laser.rotation = rot

	if abs($Laser.rotation) > PI/2.0:
		$Laser/MiningHand.scale.x = -1
		$Laser/MiningHand.rotation = PI
		
		$Laser/ShovelHand.scale.x = -1
		$Laser/ShovelHand.rotation = PI
		
		$Laser/FishingHand.scale.x = -1
		$Laser/FishingHand.rotation = PI
	else:
		$Laser/MiningHand.rotation = 0
		$Laser/MiningHand.scale.x = 1
		
		$Laser/ShovelHand.rotation = 0
		$Laser/ShovelHand.scale.x = 1
		
		$Laser/FishingHand.rotation = 0
		$Laser/FishingHand.scale.x = 1
	
	if selectedTool != 0 || subSelectedTool != 2:
		$PositionIndependent/Bobber.visible = false
		$PositionIndependent/FishingLine.points = []
	else:
		var hand = $Laser/FishingHand
		if bitFish:
			hand.position = Vector2(randf_range(-1,1), randf_range(-1,1))*0.5
		else:
			hand.position = Vector2(randf_range(-castDist,castDist), randf_range(-castDist,castDist))*0.5
		
		if abs($Laser.rotation) > PI/2.0:
			hand.rotation = PI+PI*castDist/2
		else:
			hand.rotation = -PI*castDist/2
		
		if castDist > 0:
			if !$Laser/FishingHand/Charge.playing:
				$Laser/FishingHand/Charge.pitch_scale = randf_range(0.75,1.25)
				$Laser/FishingHand/Charge.play()
				
			$Laser/FishingHand/Charge.volume_db = linear_to_db(castDist)+5
		elif $Laser/FishingHand/Charge.playing:
			$Laser/FishingHand/Charge.stop()
	
	if isMining && selectedTool == 0:
		speedModifier = 0.5
		if !$MiningTarget/LaserOn.playing:
			$MiningTarget/LaserBegin.play()
			$MiningTarget/LaserOn.play()
			$MiningTarget/CPUParticles2D.restart()
		if laserProgress < 1:
			laserProgress += 6*delta
		$MiningTarget.visible = true
		$Laser/MiningHand.position.x += randf_range(-35,0.0)*delta
	else:
		if $MiningTarget/LaserOn.playing:
			$MiningTarget/LaserOn.stop()
			$MiningTarget/LaserEnd.play()
		if laserProgress > 0:
			laserProgress -= 6*delta
		$MiningTarget.visible = false
	
	$Laser/Beam.position.x = $Laser/MiningHand.position.x + 13
	$Laser/MiningHand.position.x = lerpf($Laser/MiningHand.position.x, 0.0, 1-pow(0.001, delta))
	$Laser/Beam.material.set_shader_parameter("progress",clampf(laserProgress,0.0,1.0))
	
	if $mainSprite/Hit.modulate.a > 0:
		if velocity.x < 0:
			$mainSprite/Hit.flip_h = true
		else:
			$mainSprite/Hit.flip_h = false
			
		$mainSprite/Hit.modulate.a -= 1*delta
	
	if direction == -1:
		mainSprite.flip_h = true
	else:
		mainSprite.flip_h = false
	
	## Play walking sounds
	if mainSprite.animation == "walk":
		if mainSprite.frame == 0 || mainSprite.frame == 3:
			if !hasStepped:
				$Step.pitch_scale = randf_range(0.75,1)
				$Step.play()
				
				var obj = load("res://Scenes/dust_particles_player.tscn").instantiate()
				obj.z_index -= 4
				obj.global_position = global_position
				get_parent().add_child(obj,true)
				
				hasStepped = true
		else:
			hasStepped = false
	
	if isAuthority: ##MULTIPLAYER AUTHORITY
		check_artifact()
		check_floor()
		
		if !cutsceneLock:
			set_collision_mask_value(1,!Global.noclip)
		
		interactHover = false
		currentFoodCooldown -= 1*delta
		
		$Crosshair.global_position = $MiningTarget.global_position
		$Crosshair.visible = Global.controllerActive
		
		if currentRollCooldown > 0 && currentRollCooldown < rollCooldown:
			$RollProgress.visible = true
			$RollProgress.value = 1-(currentRollCooldown/rollCooldown)
		else:
			$RollProgress.visible = false
		
		if is_instance_valid(starlauncher):
			global_position = global_position.move_toward(starlauncher.global_position,250*delta)
			if global_position.distance_to(starlauncher.global_position) < 2:
				if !starlauncherFinished:
					starlauncher.start_launch.rpc()
					starlauncherFinished = true
					toggle_visibility(false)
		
		if inventory.get_count(heldItems[selectedTool]) <= 0:
			if $Hand/Weapon/Hand/Item.visible:
				change_held_item.rpc(false)
		elif !$Hand/Weapon/Hand/Item.visible:
			change_held_item.rpc(true)
			
		if Input.is_action_just_pressed("hide_ui"):
			$Canvas.visible = !$Canvas.visible
			
		inDungeon = Global.is_in_dungeon()
		
		if Global.controllerActive:
			$CursorCollision.global_position = miningTargetPos
		else:
			$CursorCollision.global_position = get_global_mouse_position()
		
		uiOpen = $Canvas/ResearchMenu.visible || $Canvas/ui_inventory.visible || $Canvas/InventoryDisplayBuilding.visible || $Canvas/ToolWheel.visible# || fishingGameActive
		
		if main.worldColor.get_luminance() > 0.6:
			dayIcon.texture = load("res://Sprites/uiday-day.png")
		else:
			dayIcon.texture = load("res://Sprites/uiday-night.png")
		
		$Camera.position = $Camera.position.lerp(Vector2.ZERO,1-pow(0.04,delta))
		
		check_boss_music()
		
		if currentWeaponDelay > 0:
			currentWeaponDelay -= 1*delta
		
		if lastWeaponData != $weapon_configuration.inventoryData:
			set_weapon.rpc()
			
		healthBar.max_value = hp
		healthBar.custom_minimum_size.x = hp*48
		healthBar.size.x = hp*48
		healthBarTexture.size.x = healthBar.size.x
		healthBar.value = currentHP
			
		dayLabel.text = tr("Day") + " " + str(ceil(main.time/main.dayLength))
		
		hitZoom = hitZoom.lerp(Vector2.ZERO, 1 - pow(0.05, delta))
		
		activeCameraShake = Vector2(randf_range(-cameraShake,cameraShake),randf_range(-cameraShake,cameraShake))
		cameraShake = lerpf(cameraShake, 0.0, 4*delta)
		$Camera.position += activeCameraShake*Global.screenshake
		
		healthBar.custom_minimum_size.y = lerpf(healthBar.custom_minimum_size.y, 36, 2*delta)
		
		if !$Camera.is_current():
			$Camera.make_current()
		
		if Input.is_action_just_pressed("ui_cancel"):
			if Global.controllerActive:
				if Global.currentCloseMenuDelay <= 0:
					if !Global.virtualKeyboard.visible:
						if $Canvas/PauseMenu.visible:
							Global.currentCloseMenuDelay = Global.closeMenuDelay
							close_pause()
						elif uiOpen:
							if $Canvas/ui_inventory.visible:
								close_inventory()
								Global.currentCloseMenuDelay = Global.closeMenuDelay
							else:
								if $Canvas/InventoryDisplayBuilding.visible:
									$Canvas/InventoryDisplayBuilding.visible = false
									Global.currentCloseMenuDelay = Global.closeMenuDelay
								if $Canvas/ResearchMenu.visible:
									$Canvas/ResearchMenu.visible = false
									Global.currentCloseMenuDelay = Global.closeMenuDelay
								
		if !$PositionIndependent/BuildPreview.visible:
			if Input.is_action_just_pressed("pause"):
				if uiOpen:
					if $Canvas/ui_inventory.visible:
						close_inventory()
					else:
						$Canvas/ui_inventory.visible = false
						$Canvas/InventoryDisplayBuilding.visible = false
						$Canvas/ResearchMenu.visible = false
				elif !chatSelected:
					toggle_pause()
		
		$Canvas/FPS.text = str(Engine.get_frames_per_second())

		## Sets the debug info in the f3 menu
		if debugLabel.visible:
			debugLabel.text = "Multiplayer ID: {0}\nWorld Seed: {1}\nController: {2}\nPosition: {3}\nRain Time Remaining: {4}\nTime Until Next Rain: {5}".format([name, Global.generationInfo.Seed, Global.controllerActive, global_position, snappedf(main.rainLength, 0.1), snappedf(main.rainTimer, 0.1)])
		
		if canInteract && !cutsceneLock:
			if canMove:
				if currentRollCooldown <= 0:
					if Input.is_action_just_pressed("roll"):
						rolled.emit()
						if !inVehicle:
							rollVelocity += lastMoveDirection*rollStrength
							currentRollCooldown = rollCooldown
							rollStarted = true
							
							start_roll_particles.rpc(lastMoveDirection)
							
							play_sound.rpc("RollSound", true, randf_range(0.5,1))
				else:
					if has_effect("starground:effect_endurance"):
						currentRollCooldown -= 2*delta 
					else:
						currentRollCooldown -= 1*delta 

			# START TYPING MESSAGE
			if Input.is_action_just_pressed("start_chat"):
				if Global.controllerActive:
					Global.virtualKeyboard.open($Canvas/BottomBar/HBoxContainer/ChatBox.lineEdit)
				else:
					$Canvas/BottomBar/HBoxContainer/ChatBox.lineEdit.grab_focus()
				
			
			# ACCESS INVENTORY
			if Input.is_action_just_pressed("inventory") || ($Canvas/ui_inventory.visible && position.distance_to(openPosition) > interactRange && hasOpenedObject):
				if $Canvas/ui_inventory.visible:
					close_inventory()
				else:
					open_inventory(true)
				$PositionIndependent/BuildPreview.visible = false
				$Canvas/InventoryDisplayBuilding.visible = false
				$Canvas/ResearchMenu.visible = false
				
			# ACCESS BUILDING MENU
			if Input.is_action_just_pressed("building_menu"):
				if $Canvas/InventoryDisplayBuilding.visible:
					$Canvas/InventoryDisplayBuilding.visible = false
				else:
					$Canvas/InventoryDisplayBuilding.visible = true
					$PositionIndependent/BuildPreview.visible = false
					$Canvas/ResearchMenu.visible = false
					close_inventory()
					
			if Input.is_action_just_pressed("research_menu"):
				if (!Global.controllerActive || (Global.controllerActive && Global.currentCloseMenuDelay <= 0)):
					if $Canvas/ResearchMenu.visible:
						$Canvas/ResearchMenu.visible = false
					elif !$PositionIndependent/BuildPreview.visible:
						close_inventory()
						$Canvas/ResearchMenu.visible = true
						$PositionIndependent/BuildPreview.visible = false
						$Canvas/InventoryDisplayBuilding.visible = false
						Global.currentCloseMenuDelay = Global.closeMenuDelay
			
			#CANCEL BUILD
			if $PositionIndependent/BuildPreview.visible:
				if Input.is_action_just_pressed("building_cancel"):
					$PositionIndependent/BuildPreview.visible = false
				
		if Global.mouseInWindow && !$Canvas/ToolWheel.visible && !$Canvas/FishingMinigame.visible && !cutsceneLock:
			lookDirection = Input.get_vector("look_left", "look_right", "look_up", "look_down")
			
			if Global.controllerActive:
				if Input.is_action_just_pressed("dpad_up"):
					if buildingOffset.y > -8:
						buildingOffset.y -= 1
				if Input.is_action_just_pressed("dpad_down"):
					if buildingOffset.y < 8:
						buildingOffset.y += 1
				if Input.is_action_just_pressed("dpad_left"):
					if buildingOffset.x > -8:
						buildingOffset.x -= 1
				if Input.is_action_just_pressed("dpad_right"):
					if buildingOffset.x < 8:
						buildingOffset.x += 1
						
				if Input.is_action_just_pressed("look_left") || Input.is_action_just_pressed("look_up")\
				|| Input.is_action_just_pressed("look_down") || Input.is_action_just_pressed("look_right"):
					buildingOffset = Vector2.ZERO
			
			if Global.hitFirst && !$PositionIndependent/BuildPreview.visible:
				var interactTargetPos
				if Global.controllerActive:
					interactTargetPos = global_position+lookDirection*miningRange
				else:
					interactTargetPos = get_global_mouse_position()
					
				if selectedTool == 0 && subSelectedTool != 2 && Global.smoothMining && Global.controllerActive:
					miningOffset += lookDirection*delta*200.0
					miningOffset = miningOffset.limit_length(miningRange)
					$MiningTargetRay.target_position = miningOffset
				else:
					miningOffset = Vector2.ZERO
					$MiningTargetRay.target_position = to_local(interactTargetPos)
					
				var collider = $MiningTargetRay.get_collider()
				
				if collider:
					miningTargetPos = collider.global_position
				else:
					buildingOffset = Vector2.ZERO
					miningTargetPos = to_global($MiningTargetRay.target_position)

			else:
				if Global.controllerActive:
					if $PositionIndependent/BuildPreview.visible:
						miningTargetPos = (global_position+lookDirection*48)+(buildingOffset*16)
					else:
						buildingOffset = Vector2.ZERO
						if selectedTool == 0 && subSelectedTool != 2 && Global.smoothMining:
							miningOffset += lookDirection*delta*200.0
							miningOffset = miningOffset.limit_length(miningRange)
							miningTargetPos = global_position + miningOffset
						else:
							miningOffset = Vector2.ZERO
							miningTargetPos = global_position+lookDirection*miningRange
				else:
					miningTargetPos = get_global_mouse_position()

		## Find object to interact with on left click
		if Global.controllerActive:
			$Cursor.global_position = miningTargetPos
		else:
			$Cursor.global_position = get_global_mouse_position()
		
		$PositionIndependent/Highlight.visible = false
		$PositionIndependent/Highlight.self_modulate = Color(1,1,1,1)
		
		$PositionIndependent/Highlight/Sprite2D.visible = false
		
		process_hotbar()
			
		if canInteract && !cutsceneLock && !uiOpen:
			if Input.is_action_just_pressed("scroll_down") && Input.is_action_pressed("ctrl"):
				if (targetZoom.x > 1.5 || !zoomLimit): #1.5
					targetZoom /= 1.075 + delta
				
			if Input.is_action_just_pressed("scroll_up") && Input.is_action_pressed("ctrl"):
				if (targetZoom.x < 8 || !zoomLimit):
					targetZoom *= 1.075 + delta
				
			if Input.is_action_just_pressed("toggle_mining_snapping"):
				Global.hitFirst = !Global.hitFirst
				
			if Input.is_action_just_pressed("toggle_smooth_mining"):
				Global.smoothMining = !Global.smoothMining
		
		process_object_interaction()
		process_weapon(delta)
		process_movement(delta)

		## This UI stuff is stupid and terrible, but I haven't found another solution yet

		var uiscale
		
		if get_viewport().size.y*1.78 > get_viewport().size.x:
			uiscale = float(get_viewport().size.y)/float(get_viewport().size.x)*1.78
		else:
			uiscale = float(get_viewport().size.x)/float(get_viewport().size.y)/1.78
		
		var uiscaleCorrect = 1.0
		
		if get_window().content_scale_factor >= 1.5:
			uiscaleCorrect = 2.0/3.0
		elif get_window().content_scale_factor >= 1.25:
			uiscaleCorrect = 0.8
		elif get_window().content_scale_factor >= 1:
			uiscaleCorrect = 1.0
		elif get_window().content_scale_factor >= 0.75:
			uiscaleCorrect = 4.0/3.0
		elif get_window().content_scale_factor >= 0.5:
			uiscaleCorrect = 6.0/3.0
		
		if hasDied:
			$Camera.zoom = Vector2(6,6)*uiscaleCorrect*uiscale
		else:
			$Camera.zoom = (targetZoom + hitZoom)*uiscaleCorrect*uiscale
		
	if isAuthority:
		currentVelocity = velocity
	else:
		velocity = currentVelocity
		
	if hasDied:
		speedModifier = 1.0
		
	move_and_slide()


@rpc("call_local", "any_peer")
func cancel_fishing(caughtItemID = ""):
	$PositionIndependent/Bobber/ItemSprite.texture = null
	$PositionIndependent/Bobber.visible = false
	$FishingHands.visible = false
	bitFish = null
	targetFish = null
	bobberReady = false
	fishingGameActive = false
	castDist = 0.0
	bobberReturned = true
	holdingFish = false
	cutsceneLock = false
	$CastStrength.modulate.a = 0.0
	$Laser/FishingHand/Charge.stop()
	#$Laser.visible = true
	
	if caughtItemID && isServer:
		var fishItem = ModAPI.create_item_dict(caughtItemID, 1)
		
		if !inventory.add_item(fishItem):
			get_node("/root/Multiplayer").create_item(fishItem, global_position, 0)
		else:
			play_sound.rpc("Pickup")


func process_object_interaction():
	if canInteract && !cutsceneLock:
		## OBJECT HIGHLIGHT AND SELECTION
		var overlaps = $Cursor.get_overlapping_bodies()
		if overlaps.size() > 0 && !$PositionIndependent/BuildPreview.visible:
			var object = overlaps[0]
			
			if object is Buildable:
				if is_instance_valid(lastHoveredObject):
					lastHoveredObject.hovered = false
					lastHoveredObject.set_indicator_visibility(false)
					
				lastHoveredObject = object
				object.hovered = true
				object.set_indicator_visibility(true)
				
				if Input.is_action_just_pressed("middle_click") && !uiOpen:
					var result = $PositionIndependent/BuildPreview.select_new_object(object.buildingID)
					if result:
						$PositionIndependent/BuildPreview.visible = true
						$BuildingPicker.pitch_scale = randf_range(0.75,1.25)
						$BuildingPicker.play()
			
			var collider = object.get_node_or_null("CollisionShape2D")
			if collider != null:
				$PositionIndependent/Highlight.visible = true
				if collider.shape is RectangleShape2D:
					$PositionIndependent/Highlight.size = collider.shape.size + Vector2(4,4)
				else:
					$PositionIndependent/Highlight.size = Vector2(16,16)
				
				if $PositionIndependent/Highlight.size.x < 16 || $PositionIndependent/Highlight.size.y < 16:
					$PositionIndependent/Highlight.texture = load("res://Sprites/highlight_small.png")
				else:
					$PositionIndependent/Highlight.texture = load("res://Sprites/highlight.png")
	
				$PositionIndependent/Highlight.global_position = collider.global_position - $PositionIndependent/Highlight.size/2
			
			var inv = object.get_node_or_null("inventory_component")
			var interactable = object.has_method("exclusive_interact")
			
			var hasCheck = object.has_method("check_exclusive_interact")
			var canInteract = true
			if hasCheck:
				canInteract = object.check_exclusive_interact()
			
			$PositionIndependent/Highlight/ItemIcon.visible = false
			
			if inv != null || (interactable && canInteract):
				
				var interactItemID = object.get("interactItemID")
				if interactItemID:
					$PositionIndependent/Highlight/ItemIcon.visible = true
					$PositionIndependent/Highlight/ItemIcon.texture = ModAPI.get_item_data(interactItemID).Sprite
				else:
					$PositionIndependent/Highlight/ItemIcon.visible = false
				
				$PositionIndependent/Highlight/ItemIcon/Label.text = str(object.get("interactItemAmount"))
				
				if object is Conveyor || object is Mover:
					if Input.is_action_just_pressed("grab_item"):
						grab_item.rpc_id(1, object.get_path())
				
				if object.is_in_group("Inventories") || interactable:
					if position.distance_to(object.global_position) > miningRange:
						$PositionIndependent/Highlight.self_modulate = Color(1,0.5,0.5,1)
					else: 
						$PositionIndependent/Highlight.self_modulate = Color(0,0.9,1,1)
						$PositionIndependent/Highlight/Sprite2D.visible = true
						interactHover = true
						if Input.is_action_just_pressed("interact"):
							if !$Canvas/ui_inventory.visible:
								if object.has_method("exclusive_interact"):
									object.exclusive_interact.rpc()
								else:
									inventory_check.rpc_id(1, object.get_path())
								#set_weapon.rpc()
		
		elif is_instance_valid(lastHoveredObject):
			lastHoveredObject.hovered = false
			lastHoveredObject.set_indicator_visibility(false)
			lastHoveredObject = null	


func process_weapon(delta):
	if canInteract && !cutsceneLock:
		if canCombo && currentComboTimer < cooldown/3.0:
			if Input.is_action_pressed("tool_action"):
				comboActive = true
		
		## START MINING
		if currentSpecialWeaponCooldown <= 0:
			if selectedTool == 1:
				if !specialRecharged:
					specialRecharged = true
					weapon_special_recharged.rpc()
					
				if Input.is_action_just_pressed("tool_action_secondary") && !interactHover && !uiOpen && !$PositionIndependent/BuildPreview.visible:
					for i in $weapon_configuration.inventoryData:
						if i != null:
							var data = ModAPI.get_item_data(i.ID)
							var script = data.get("AttackScript")
							if script:
								special_weapon_script.rpc(script)
								currentSpecialWeaponCooldown = specialWeaponCooldown
		else:
			currentSpecialWeaponCooldown -= 1*delta
			specialRecharged = false
		
		if selectedTool == 0 && !uiOpen && !$PositionIndependent/BuildPreview.visible:
			if subSelectedTool == 1:
				$PositionIndependent/land_tile_highlight.visible = !$PositionIndependent/Highlight.visible
				var tileBoxPos
					
				if Global.controllerActive:
					tileBoxPos = miningTargetPos
				else:
					tileBoxPos = get_global_mouse_position()
				
				var posTrack = tileBoxPos+Vector2(8,8)
				$PositionIndependent/land_tile_highlight.global_position = posTrack.snapped(Vector2(16,16))-Vector2(8,8)
		
				if global_position.distance_to(get_global_mouse_position()) < miningRange:
					$PositionIndependent/land_tile_highlight.modulate = Color.WHITE
					if Input.is_action_pressed("tool_action"):
						break_tile()
				else:
					$PositionIndependent/land_tile_highlight.modulate = Color.hex(0xE43B44FF)
			elif subSelectedTool == 2:
				var bobber = $PositionIndependent/Bobber
				var hand = $Laser/FishingHand
				
				## Break line
				if bobber.global_position.distance_to(global_position) > maxCastDist*2 && bobber.visible:
					cancel_fishing.rpc("")
				
				## Reel in
				if Input.is_action_just_pressed("tool_action") && !bobberReturned:
					if is_instance_valid(bitFish):
						bitFish.try_catch.rpc_id(1)
					else:
						start_reel.rpc()
				
				## Charge cast
				if Input.is_action_pressed("tool_action") && !bitFish && bobberReturned:
					$CastStrength.modulate.a = 1.0
					$CastStrength/MaxCastText.modulate.a = 0.0
					bobber.visible = false
					
					if chargeTween:
						chargeTween.kill()
					
					if castDist < 1.0 && !hitMaxCast:
						castDist += 1.0*delta
					else:
						hitMaxCast = true
						castDist *= 1 - 1*delta
						
					$CastStrength.value = castDist
				
				## Release Charge
				if Input.is_action_just_released("tool_action") && !bitFish && bobberReturned:
					start_cast.rpc($Hand.global_rotation, castDist)
		else:
			cancel_fishing()
			$PositionIndependent/land_tile_highlight.visible = false
		
		if currentCooldown <= 0 || (canCombo && currentComboTimer <= 0 && comboActive):
			if !recharged:
				recharged = true
				if !comboActive:
					weapon_recharged.rpc()
				
			if !comboActive:
				currentComboHit = 0
				swingDir = 0
			
			if (Input.is_action_pressed("tool_action") || (canCombo && comboActive)) && !uiOpen && !$PositionIndependent/BuildPreview.visible && ((subSelectedTool == 0 && selectedTool == 0) || selectedTool != 0):
				
				swingDir += 1
				
				if selectedTool == 0:
					isMining = true
				if selectedTool == 1:
					comboActive = false
					if currentComboHit < 2:
						currentComboTimer = cooldown/2.0
						currentComboHit += 1
						canCombo = true
					else:
						currentComboHit = 0
						currentCooldown = cooldown
						canCombo = false

				tool_action.rpc(delta, swingDir)
			else:
				isMining = false
				speedModifier = 1
		else:
			currentCooldown -= 1*delta
			
			if currentWeaponDelay > 0:
				speedModifier = 0
			else:
				speedModifier = 1
				
	if currentComboTimer > 0:
		currentComboTimer -= 1*delta
	else:
		canCombo = false


@rpc("call_local", "any_peer")
func catch_success():
	hitZoom = Vector2(1.01,1.01)
	$Laser/FishingHand/SinkHook.pitch_scale = randf_range(0.75,1.25)
	$Laser/FishingHand/SinkHook.play()
	
	var timer = get_tree().create_timer(0.5)
	timer.timeout.connect(func():fishingGameActive = true)


@rpc("call_local")
func start_cast(castAngle, castStrength):
	var line = $PositionIndependent/FishingLine
	var bobber = $PositionIndependent/Bobber
	var hand = $Laser/FishingHand
	
	castDist = castStrength
	
	bobber.global_position = global_position
	var castDir = Vector2.RIGHT.rotated(castAngle)
	bobber.visible = true
	bobberReturned = false
	hitMaxCast = false

	castDist = snappedf(castDist, 0.1)
	$CastStrength.value = castDist
	
	if castDist == 1 && isAuthority:
		$CastStrength/MaxCastText.modulate.a = 1.0
		$CastStrength/AudioStreamPlayer.play()
		
	bobber.modulate = Color(1,1,1,1)
	var targetPos = global_position + (castDir*castDist*maxCastDist)
	fishingGameActive = false
	
	$Laser/FishingHand/Cast.pitch_scale = randf_range(0.75,1.25)
	$Laser/FishingHand/Cast.volume_db = linear_to_db(castDist)
	$Laser/FishingHand/Cast.play()
	$Laser/FishingHand/Charge.stop()
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(bobber, "global_position", targetPos, 0.5)
	tween.tween_callback(func():
		var tilemap = ModAPI.get_tilemap_from_id(Global.currentRegionID)
		var tileData = tilemap.get_cell_tile_data(tilemap.local_to_map(tilemap.to_local(targetPos)))
		if !tileData:
			$PositionIndependent/Bobber/Splash.pitch_scale = randf_range(0.75,1.25)
			$PositionIndependent/Bobber/Splash.play()
			$PositionIndependent/Bobber/SplashParticles.restart()
			$PositionIndependent/Bobber/SplashParticles.emitting = true
			bobberReady = true
	)
	
	var castTween = get_tree().create_tween()
	castTween.set_ease(Tween.EASE_OUT)
	castTween.set_trans(Tween.TRANS_QUAD)
	castTween.tween_property(self,"castDist", 0.0, 0.15)
	
	chargeTween = get_tree().create_tween()
	chargeTween.set_parallel(true)
	chargeTween.tween_property($CastStrength, "modulate", Color(1,1,1,0.0), 0.5).set_delay(1.0)
	chargeTween.tween_property($CastStrength/MaxCastText, "modulate", Color(1,1,1,0.0), 0.5).set_delay(1.0)


@rpc("call_local")
func start_reel(caughtItemID = ""):
	$PositionIndependent/Bobber.modulate = Color(1,1,1,1)
	bobberReady = false
	var reelTime = 0.2
	
	var itemData
	
	if caughtItemID:
		itemData = ModAPI.get_item_data(caughtItemID)
		$PositionIndependent/Bobber/ItemSprite.texture = itemData.Sprite
		reelTime = 0.4
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property($PositionIndependent/Bobber,"global_position", $Laser/FishingHand/LineAnchor.global_position, reelTime)
	
	if caughtItemID:
		tween.tween_callback(func():
			holdingFish = true
			cutsceneLock = true
			$PositionIndependent/Bobber.visible = false
			$mainSprite.play("caught")
			$Laser/FishingHand.visible = false
			$FishingHands.visible = true
			$FishingHands/Fish.texture = itemData.Sprite
			
			var averageSize = itemData.get("AverageSize", null)
			
			var message = itemData.Name
			
			if averageSize != null:
				var size = randfn(averageSize, averageSize/8.0)
				message = "[center]{0}[p][center][color=#FEE761FF][wave amp=10.0]{1}cm".format([itemData.Name, snappedf(size*2.54, 0.1)])
			
			show_item_indicator.rpc_id(name.to_int(), caughtItemID, 0, global_position-Vector2(0,24), message, false)
			play_sound.rpc("FishHeld", true, 1.0)
		)
		tween.tween_callback(cancel_fishing.bind(caughtItemID)).set_delay(1.5)
		tween.tween_callback(func():$Laser/FishingHand.visible = true)
	else:
		tween.tween_callback(cancel_fishing.bind(caughtItemID))


func break_tile():
	var pos = $PositionIndependent/land_tile_highlight.global_position
	var tilemap = ModAPI.get_tilemap_at_position(pos)
	var tilePos = tilemap.local_to_map(tilemap.to_local(pos))
	
	var tileData = tilemap.get_cell_tile_data(tilePos)
	if tileData:
		if tileData.get_custom_data("Solid"):
			main.set_modified_tile.rpc("starground:region_veridian", tilePos, false)
	
	
func process_movement(delta):
	#speedModifier *= speedEffectModifier
	
	var moveVector = Vector2(0,0)
	
	if canMove && !movementLock && !cutsceneLock && (!Global.controllerActive || (Global.controllerActive && !uiOpen)) && !Global.virtualKeyboard.visible: 
		moveVector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if moveVector != Vector2.ZERO:
			lastMoveDirection = moveVector
	
	if !hasDied && !holdingFish:
		if rollStarted:
			if direction == 1:
				if lastMoveDirection.x < 0:
					direction = -1
				play_animation.rpc("roll")
			else:
				if lastMoveDirection.x > 0:
					direction = 1
				play_animation.rpc("roll")
		
		elif !moveVector || inVehicle:
			play_animation.rpc("idle")
		else:
			play_animation.rpc("walk")
	
	rollVelocity = rollVelocity.lerp(Vector2(0,0),1-pow(0.0005,delta))
	
	if inVehicle:
		moveVelocity = moveVelocity.lerp(Vector2(0,0),1-pow(0.1,delta))
	else:
		moveVelocity = moveVelocity.lerp(Vector2(0,0),1-pow(0.0005,delta))
		
	velocity = velocityOffset
		
	var speedmod = speedModifier*speedVehicleModifier*speedCommandModifier*speedEffectModifier
	var speedLimit = maxSpeed*speedmod
	
	var vehicleAccelModifier = 1.0
	if inVehicle:
		vehicleAccelModifier = 0.4
	else:
		vehicleAccelModifier = 1.0
	
	if speedmod > 0:
		if (moveVelocity + moveVector.normalized()*speed*delta*speedmod*vehicleAccelModifier).length() < speedLimit:
			moveVelocity += moveVector.normalized()*speed*delta*speedmod*vehicleAccelModifier
		else:
			moveVelocity += moveVector.normalized()*(clampf(speedLimit - moveVelocity.length(), 0, INF))
		
	
	if Global.is_in_automation() && !Global.noclip:
		var limit = (Global.generationInfo.Size+16)*8
		var newPos = global_position + moveVelocity*delta
		
		if abs(newPos.x-Global.currentRegion.Location.x) > limit:
			moveVelocity.x = 0.0
			
		if abs(newPos.y-Global.currentRegion.Location.y) > limit:
			moveVelocity.y = 0.0

	velocity += moveVelocity
	velocity += knockback*16
	velocity += rollVelocity
	velocityOffset = Vector2.ZERO


func process_hotbar():
	if canInteract && !cutsceneLock && !uiOpen:
		if !Input.is_action_pressed("ctrl"):
			if Input.is_action_just_pressed("scroll_up"):
				change_tool.rpc(posmod(selectedTool - 1, numHotbarSlots))
			if Input.is_action_just_pressed("scroll_down"):
				change_tool.rpc(posmod(selectedTool + 1, numHotbarSlots))
	
	#var shovelResearch = main.researchInfo.get("starground:research_terrain_manipulation", null)
	
	#if shovelResearch:
		#if shovelResearch.Complete:
			#if Input.is_action_just_pressed("change_mining_tool"):
				#change_tool.rpc(0, true, 0)
			
			
	if Input.is_action_just_pressed("hotbar_1"):
		change_tool.rpc(0)
		
	if Input.is_action_just_pressed("hotbar_2"):
		change_tool.rpc(1)
		
	if Input.is_action_just_pressed("hotbar_3"):
		change_tool.rpc(2)
		
	if Input.is_action_just_pressed("hotbar_4"):
		change_tool.rpc(3)
		
	if Input.is_action_just_pressed("hotbar_5"):
		change_tool.rpc(4)
		
	if Input.is_action_just_pressed("hotbar_6"):
		change_tool.rpc(5)
	
	cooldownStar.material.set_shader_parameter("progress", currentSpecialWeaponCooldown*(1/specialWeaponCooldown))
	for i in numHotbarSlots:
		var cooldownOverlay = get_node_or_null("Canvas/BottomBar/HBoxContainer/Toolbar/HBoxContainer/" + str(i) + "/CooldownOverlay")
			
		if cooldownOverlay:
			if i > 1 && (ModAPI.get_item_data(heldItems[i]).has("Heal") || ModAPI.get_item_data(heldItems[i]).has("Effect")):
				cooldownOverlay.material.set_shader_parameter("progress", currentFoodCooldown*(1/foodCooldown))
			elif i == selectedTool:
				cooldownOverlay.material.set_shader_parameter("progress", currentCooldown*(1/cooldown))
			else:
				cooldownOverlay.material.set_shader_parameter("progress", 0)


func _on_health_value_changed(_value):
	healthBar.custom_minimum_size.y = 36*2
	healthBar.size.y = 36*2
	
	
@rpc("call_local")
func special_weapon_script(script):
	var _script = load(script).new(self)
	

func check_artifact():
	conveyorsMove = !inventory.get_count("starground:lead_boots") > 0
	pickupRadius = setPickupRadius*(1.0 + float(inventory.get_count("starground:magnet") > 0))
	
	var rangeModifier = 1.0
	if inventory.get_count("starground:grabber") > 0:
		rangeModifier = 1.5
		
	miningRange = setMiningRange*rangeModifier
	interactRange = setInteractRange*rangeModifier
	
	$SurroundingLight.texture_scale = setLightScale*(1.0 + 2*float(inventory.get_count("starground:carrot") > 0))
	
	if inventory.get_count("starground:braided_fishing_line") > 0:
		maxCastDist = 144
	else:
		maxCastDist = 96


@rpc("call_local")
func start_roll_particles(newMoveDirection):
	$RollParticles.direction = newMoveDirection
	$RollParticles.restart()
	$RollParticles.emitting = true
	
	$RollParticles.angle_min = -rad_to_deg(newMoveDirection.angle())
	$RollParticles.angle_max = -rad_to_deg(newMoveDirection.angle())	


@rpc("call_local")
func weapon_recharged():
	$Hand/Weapon/Charged.play()
	$Hand/Weapon/Recharge.restart()
	$Hand/Weapon/Recharge.emitting = true

	
@rpc("call_local")
func weapon_special_recharged():
	$Hand/Weapon/SpecialCharged.play()
	$Hand/Weapon/SpecialRecharge.restart()
	$Hand/Weapon/SpecialRecharge.emitting = true


@rpc("call_local")
func grab_item(objectPath):
	var object = get_node_or_null(objectPath)
	var inv = object.get_node_or_null("inventory_component")
	
	if object && inv:
		if inv.inventoryData[0] != null:
			if inventory.add_item(inv.inventoryData[0]):
				show_item_indicator.rpc_id(name.to_int(), inv.inventoryData[0].ID, 1, object.global_position)
				object.delete_item()
				play_sound.rpc("Pickup")


@rpc("call_local")
func show_item_indicator(itemID, amount, pos = global_position, overrideText = "", moveUp = true):
	var indicator = load("res://Scenes/item_pickup_indicator.tscn").instantiate()
	indicator.global_position = pos
	indicator.itemID = itemID
	indicator.amount = amount
	indicator.moveUp = moveUp
	indicator.overrideText = overrideText
	get_parent().add_child(indicator)


func _on_sprite_animation_finished():
	if mainSprite.animation == "roll":
		rollStarted = false


## Disconnects players when connection to a host is lost
func _on_tree_exiting():
	if multiplayer.multiplayer_peer == main.peer:
		if !isServer:
			main._on_server_disconnect()
