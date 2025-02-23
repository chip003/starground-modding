class_name ObjectResource extends Breakable
## This class is a parent class of all resources that spawn in the world
## It will automatically handle despawning

#var lifespan = randi_range(30,120)
var despawn = true
var timer : Timer
var main
var playerDrops : Array = []
var beingMined = false
var landResource

var startingCollisionLayer = self.collision_layer
var inactiveCollisionLayer = 8

var regionID

func _ready():
	super._ready()
	
	regionID = ModAPI.get_region_id_at_position(global_position)
	if isServer:
		timer = Timer.new()
		timer.timeout.connect(start_regenerate)
		add_child(timer,true)
		
		deactivate()
		
		Global.fully_loaded.connect(
		func():
			await get_tree().physics_frame
			start_regenerate()
		)
	else: #joining from client
		deactivate()
		check_regen.rpc_id(1)


@rpc('any_peer')
func check_regen():
	if visible:
		_regenerate.rpc_id(multiplayer.get_remote_sender_id())


func start_regenerate():
	var colOffset = $CollisionShape2D.shape.size/2.0
	var colPos = $CollisionShape2D.position
	var space_state : PhysicsDirectSpaceState2D = get_parent().get_world_2d().direct_space_state
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(global_position-colOffset+colPos, global_position+colOffset+colPos, 0b0111)
	query.collide_with_bodies = true
	query.hit_from_inside = true
	var result : Dictionary = space_state.intersect_ray(query)
	
	var tilemap = ModAPI.get_tilemap_at_position(global_position)
	var tileAtlas
	var tileData
	
	if tilemap:
		tileAtlas = tilemap.get_cell_atlas_coords(tilemap.local_to_map(tilemap.to_local(global_position)))
		tileData = tilemap.get_cell_tile_data(tilemap.local_to_map(tilemap.to_local(global_position)))
	
	var onFloor = false
	if regionID == "starground:region_tyria":
		if tileAtlas.x < 3 && tileAtlas.y > 7:
			onFloor = true
	
	if !result && !onFloor:
		if tileData || is_in_group("Dungeon"):
			if landResource:
				if isServer:
					var newNode = landResource.instantiate()
					newNode.global_position = global_position
					get_parent().add_child(newNode, true)
					get_tree().call_group("Collector", "check_resource_change", newNode)
					queue_free()
			else:
				if isServer:
					timer.stop()
					_regenerate.rpc()
				else:
					_regenerate()
		else:
			if !landResource:
				if isServer:
					var newNode = load("res://Scenes/oil_deposit.tscn").instantiate()
					newNode.global_position = global_position
					newNode.landResource = load(scene_file_path)
					get_parent().add_child(newNode, true)
					get_tree().call_group("Collector", "check_resource_change", newNode)
					queue_free()
			else:
				if isServer:
					timer.stop()
					_regenerate.rpc()
				else:
					_regenerate()
	else:
		if isServer:
			timer.start(randf_range(10,30))
		deactivate()
		


@rpc("call_local")
func _regenerate():
	self.collision_layer = startingCollisionLayer
	update_hits(hitCount,hitCount)
	if isServer:
		repairTimer.stop()
	
	visible = true
	beingMined = false


@rpc("call_local")
func deactivate():
	self.collision_layer = inactiveCollisionLayer
	visible = false
	
	if isServer:
		timer.start(randf_range(10.0, 30.0))


func spawn_items():
	if visible:
		var root = get_node("/root/Multiplayer")
		
		if get_node_or_null("inventory_component") != null:
			for item in $inventory_component.inventoryData:
				if item != null:
					item.Held = false
					dropData.push_back(item)
					
		_add_before_drop()
		
		if dropItems:
			for i in range(dropData.size()):
				var dropItem = dropData[i].duplicate(true)
				root.create_item(dropItem, position, 50)
				
			for i in range(playerDrops.size()):
				var dropItem = playerDrops[i]
				root.create_item(dropItem, position, 50)
			playerDrops = []
		
		deactivate.rpc()
