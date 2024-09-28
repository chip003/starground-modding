class_name Buildable extends Breakable

var startOffset = Vector2.ZERO
var hasBuildLanded = false
@export var buildingID = ""
@export var showSameIndicators = false
var runFallAnimation = true

var setPowerConsumption = 0.0
var setPowerGeneration = 0.0

var powerConsumption = 0.0
var powerGeneration = 0.0

var areaIndicator = false
var indicatorNode
var hovered = false

var powerCoil = null

@onready var noPower = get_node_or_null("noPower")
@onready var noConnection = get_node_or_null("noConnection")

var buildingInventory

func get_custom_class(): return "Buildable"


func _exit_tree():
	get_tree().call_group("Minimap", "erase_building", global_position, self, true)


func _enter_tree():
	var powerData = Global.buildingsTable.get(buildingID,null)
	if powerData:
		if powerData.PowerStatus < 0:
			setPowerConsumption = abs(powerData.PowerStatus)
		else:
			setPowerGeneration = powerData.PowerStatus


func _ready():
	super()
	
	if buildingID == "":
		print("BAD BUILDING ID", " ", scene_file_path)
	
	add_to_group("Buildable")
	
	startOffset = $mainSprite.position
	
	if get_custom_class() != "Building":
		add_to_group(get_custom_class())
	
	if runFallAnimation:
		$mainSprite.modulate.a = 0
		$mainSprite.position.y -= 32
		
		var tween = get_tree().create_tween()
		tween.tween_property($mainSprite,"position",startOffset,0.25)
		tween.parallel().tween_property($mainSprite,"modulate",Color(1,1,1,1),0.25)
		tween.tween_callback(build_landed)
	else:
		hasBuildLanded = true
	
	indicatorNode = get_node_or_null("areaIndicator")
	if indicatorNode:
		indicatorNode.visible = false
	
	if multiplayer.is_server():
		if is_in_group("Power"):
			get_tree().call_group("TeslaCoil","check_new_building",self)
		
	buildingInventory = get_node_or_null("inventory_component")
	
	if Global.activePlayer && is_instance_valid(Global.activePlayer):
		var buildPreview = Global.activePlayer.get_node("PositionIndependent/BuildPreview")
		if buildPreview.showLastIndicators:
			if buildPreview.nodeType == get_custom_class():
				set_indicator_visibility(true)
	
	if buildingInventory:
		get_tree().call_group("Mover","check_inventory")
		
	get_tree().call_group("Minimap", "draw_building", global_position, self, true)


func set_power_visibility(val):
	if noPower:
		noPower.visible = val
	
	
func set_connection_visibility(val):
	if noConnection:
		noConnection.visible = val


func _add_before_drop():
	if buildingID != "":
		if Global.buildingsTable.has(buildingID):
			for i in Global.buildingsTable[buildingID].Ingredients:
				dropData.push_back(Global.create_item_dict(i.ID, i.Amount))


func set_indicator_visibility(val):
	if indicatorNode:
		indicatorNode.visible = val


func build_landed():
	var obj = load("res://Scenes/dust_particles.tscn").instantiate()
	obj.z_index -= 4
	get_parent().add_child(obj,true)
	obj.global_position = global_position
	hasBuildLanded = true
	shakeX = 2
	start_hit_shake()
	
	var landPlayer = load("res://Scenes/sound_player.tscn").instantiate()
	landPlayer.global_position = global_position
	landPlayer.sounds = [
		load("res://Sounds/Sound Effects/buildingland1.wav"),
		load("res://Sounds/Sound Effects/buildingland2.wav"),
		load("res://Sounds/Sound Effects/buildingland3.wav"),
	]
	
	landPlayer.pitch_scale = randf_range(1/($CollisionShape2D.shape.size.x/12.0),1/($CollisionShape2D.shape.size.x/24.0))
	landPlayer.volume_db = 0 - 10/($CollisionShape2D.shape.size.x/16.0)
	
	get_parent().add_child(landPlayer)
