extends Resource

func build():
	for i in buildingsTable:
		buildingsTable.get(i).merge(buildingsDefault)

var buildingsDefault = {
	"UsesFuel": false,
	"CanPlaceLand": true,
	"CanPlaceWater": false,
	"CanPlaceShore": false,
	"PowerStatus": 0,
	"PlayerCollision": true,
	"SpriteArray": [],
	"SpriteOffset": Vector2(0,0),
	"PositionOffset": Vector2(0,0),
	"ObjectSize": Vector2(1,1),
	"CanRotate": false,
	"BuildingCategory": "Miscellaneous",
	"Waterproof": true,
	"BannedRegions": [],
}

var buildingsTable = {
	#region PRODUCTION
	"starground:building_furnace": {
		"ObjectName": "Furnace",
		"ObjectPath": "res://Scenes/furnace.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/furnace.png"),
		"SpriteOffset": Vector2(0,-3),
		"Description": "KEY_BUILDING_FURNACE",
		"UsesFuel": true,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_oven": {
		"ObjectName": "Oven",
		"ObjectPath": "res://Scenes/oven.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/oven.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,-7),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_OVEN",
		"PowerStatus": 0,
		"UsesFuel": true,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
			{
				"ID": "starground:stone",
				"Amount": 5,
			}
		]
	},
	
	"starground:building_brewing_station": {
		"ObjectName": "Brewing Station",
		"ObjectPath": "res://Scenes/brewing_station.tscn",
		"ObjectSize": Vector2(3,2),
		"Sprite": load("res://Sprites/brewing_station.png"),
		"Description": "KEY_BUILDING_BREWING_STATION",
		"UsesFuel": true,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:iron_ingot",
				"Amount": 10,
			}
		]
	},
	
	"starground:building_trough": {
		"ObjectName": "Trough",
		"ObjectPath": "res://Scenes/trough.tscn",
		"ObjectSize": Vector2(4,2),
		"Sprite": load("res://Sprites/trough_icon.png"),
		"Description": "KEY_BUILDING_TROUGH",
		"BuildingCategory": "Miscellaneous",
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
			{
				"ID": "starground:iron_ingot",
				"Amount": 5,
			}
		]
	},
	
	"starground:building_electric_furnace": {
		"ObjectName": "Electric Furnace",
		"ObjectPath": "res://Scenes/electric_furnace.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/electric_furnace.png"),
		"Description": "KEY_BUILDING_ELECTRIC_FURNACE",
		"PowerStatus": -10,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 10,
			},
			{
				"ID": "starground:steel",
				"Amount": 10,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_crafter": {
		"ObjectName": "Crafter",
		"ObjectPath": "res://Scenes/crafter.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/crafter.png"),
		"SpriteOffset": Vector2(0,-3),
		"Description": "KEY_BUILDING_CRAFTER",
		"PowerStatus": -5,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_purifier": {
		"ObjectName": "Purifier",
		"ObjectPath": "res://Scenes/purifier.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/purifier.png"),
		"Description": "KEY_BUILDING_PURIFIER",
		"BuildingCategory": "Production",
		"PowerStatus": -8,
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 5,
			},
			
			{
				"ID": "starground:steel",
				"Amount": 5,
			},
			
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_collector": {
		"ObjectName": "Collector",
		"ObjectPath": "res://Scenes/collector.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/collector.png"),
		"Description": "KEY_BUILDING_COLLECTOR",
		"PowerStatus": -5,
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 10,
			},
			{
				"ID": "starground:gear",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_oil_rig": {
		"ObjectName": "Oil Rig",
		"ObjectPath": "res://Scenes/oil_rig.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/oil_rig.png"),
		"Description": "KEY_BUILDING_OIL_RIG",
		"PowerStatus": -5,
		"CanPlaceWater": true,
		"CanPlaceLand": false,
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:rotor",
				"Amount": 5,
			},
			{
				"ID": "starground:processor",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_harvester": {
		"ObjectName": "Harvester",
		"ObjectPath": "res://Scenes/harvester.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/harvester.png"),
		"Description": "KEY_BUILDING_HARVESTER",
		"PowerStatus": -5,
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_researcher": {
		"ObjectName": "Researcher",
		"ObjectPath": "res://Scenes/researcher.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/researcher.png"),
		"Description": "KEY_BUILDING_RESEARCHER",
		"PowerStatus": -8,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 10,
			},
			{
				"ID": "starground:processor",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_foundry": {
		"ObjectName": "Foundry",
		"ObjectPath": "res://Scenes/foundry.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/foundry.png"),
		"Description": "KEY_BUILDING_FOUNDRY",
		"UsesFuel": true,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
			{
				"ID": "starground:iron_ingot",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_refiner": {
		"ObjectName": "Refiner",
		"ObjectPath": "res://Scenes/refiner.tscn",
		"ObjectSize": Vector2(3,2),
		"Sprite": load("res://Sprites/refiner.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_REFINER",
		"PowerStatus": -5,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:rotor",
				"Amount": 5,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:processor",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_thumper": {
		"ObjectName": "Thumper",
		"ObjectPath": "res://Scenes/thumper.tscn",
		"ObjectSize": Vector2(5,5),
		"Sprite": load("res://Sprites/thumper.png"),
		"Description": "KEY_BUILDING_THUMPER",
		"PowerStatus": -30,
		"UsesFuel": false,
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 20,
			},
			
			{
				"ID": "starground:steel",
				"Amount": 20,
			},
			
			{
				"ID": "starground:rotor",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_water_pump": {
		"ObjectName": "Water Pump",
		"ObjectPath": "res://Scenes/water_pump.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/water_pump.png"),
		"CanPlaceWater": true,
		"CanPlaceLand": false,
		"Description": "KEY_BUILDING_WATER_PUMP",
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 2,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 5,
			},
		]
	},
	#endregion
	
	#region LOGISTICS
	#endregion
	
	#region POWER
	"starground:building_nuclear_reactor": {
		"ObjectName": "Nuclear Reactor",
		"ObjectPath": "res://Scenes/nuclear_reactor.tscn",
		"ObjectSize": Vector2(4,4),
		"Sprite": load("res://Sprites/nuclear_reactor.png"),
		"Description": "KEY_BUILDING_NUCLEAR_REACTOR",
		"PowerStatus": 0,
		"SpriteOffset": Vector2(0, -5),
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 20,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
		]
	},
	
	"starground:building_nuclear_turbine": {
		"ObjectName": "Nuclear Turbine",
		"ObjectPath": "res://Scenes/nuclear_turbine.tscn",
		"ObjectSize": Vector2(4,4),
		"SpriteOffset": Vector2(0, -3),
		"Sprite": load("res://Sprites/nuclear_turbine.png"),
		"Description": "KEY_BUILDING_NUCLEAR_TURBINE",
		"PowerStatus": 40,
		"UsesFuel": true,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
			{
				"ID": "starground:rotor",
				"Amount": 5,
			},
		]
	},
	#endregion
	
	#region DECORATIONS
	"starground:building_fence": {
		"ObjectName": "Fence",
		"ObjectPath": "res://Scenes/fence.tscn",
		"Sprite": load("res://Sprites/fence_icon.png"),
		"Description": "KEY_BUILDING_FENCE",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_fence_gate": {
		"ObjectName": "Fence Gate",
		"ObjectPath": "res://Scenes/fence_gate.tscn",
		"Sprite": load("res://Sprites/fence_gate_icon.png"),
		"Description": "KEY_BUILDING_FENCE",
		"BuildingCategory": "Decorations",
		#"SpriteOffset"
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 2,
			},
			{
				"ID": "starground:stone",
				"Amount": 2,
			},
		]
	},
	#endregion
	
	#region MISC
	#endregion

	"starground:building_boat": {
		"ObjectName": "Boat",
		"ObjectPath": "res://Scenes/boat.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/boat.png"),
		"Description": "KEY_BUILDING_BOAT",
		"CanPlaceWater": true,
		"CanPlaceLand": false,
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_skateboard": {
		"ObjectName": "Skateboard",
		"ObjectPath": "res://Scenes/skateboard.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/skateboard.png"),
		"Description": "KEY_BUILDING_SKATEBOARD",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:steel",
				"Amount": 10,
			},
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_farm_plot": {
		"ObjectName": "Farm Plot",
		"ObjectPath": "res://Scenes/farm_plot.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/farm_plot.png"),
		"Description": "KEY_BUILDING_FARM_PLOT",
		"BuildingCategory": "Production",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_plant_1": {
		"ObjectName": "Plant 1",
		"ObjectPath": "res://Scenes/plant_1.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/plant_1.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_PLANT",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
			
			{
				"ID": "starground:stone_brick",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_plant_2": {
		"ObjectName": "Plant 2",
		"ObjectPath": "res://Scenes/plant_2.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/plant_2.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_PLANT",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
			
			{
				"ID": "starground:stone_brick",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_plant_3": {
		"ObjectName": "Plant 3",
		"ObjectPath": "res://Scenes/plant_3.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/plant_3.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_PLANT",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
			
			{
				"ID": "starground:stone_brick",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_christmas_tree": {
		"ObjectName": "Christmas Tree",
		"ObjectPath": "res://Scenes/christmas_tree.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/christmas_tree.png"),
		"SpriteOffset": Vector2(0,-12),
		"Description": "KEY_BUILDING_CHRISTMAS_TREE",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_present": {
		"ObjectName": "Present",
		"ObjectPath": "res://Scenes/present.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/present.png"),
		"SpriteOffset": Vector2(0,-1),
		"Description": "KEY_BUILDING_CHRISTMAS_TREE",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_snowman": {
		"ObjectName": "Snowman",
		"ObjectPath": "res://Scenes/snowman.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/snowman.png"),
		"SpriteOffset": Vector2(0,-4),
		"Description": "KEY_BUILDING_CHRISTMAS_TREE",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:water",
				"Amount": 20,
			},
		]
	},
	
	"starground:building_land_tile": {
		"ObjectName": "Land Tile",
		"ObjectPath": "res://Scenes/land_tile.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/land_tile_building.png"),
		"SpriteOffset": Vector2(0,0),
		"Description": "KEY_BUILDING_LAND_TILE",
		"CanPlaceWater": true,
		"CanPlaceShore": true,
		"CanPlaceLand": false,
		"BannedRegions": ["starground:region_tyria"],
		
		"Ingredients": [
			{
				"ID": "starground:land_tile",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_training_dummy": {
		"ObjectName": "Training Dummy",
		"ObjectPath": "res://Scenes/training_dummy.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/training_dummy_full.png"),
		"SpriteOffset": Vector2(0,-6.5),
		"Description": "KEY_BUILDING_TRAINING_DUMMY",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
		]
	},
	
	
	"starground:building_treadmill": {
		"ObjectName": "Treadmill",
		"ObjectPath": "res://Scenes/treadmill.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/treadmill.png"),
		"Description": "KEY_BUILDING_TREADMILL",
		"PowerStatus": 20,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_dreadcap_monument": {
		"ObjectName": "Dreadcap Monument",
		"ObjectPath": "res://Scenes/dreadcap_monument.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/dreadcap_monument.png"),
		"SpriteOffset": Vector2(0,-6.5),
		"Description": "KEY_BUILDING_DREADCAP_MONUMENT",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:dreadcap_trophy",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_spore_monument": {
		"ObjectName": "Spore Monument",
		"ObjectPath": "res://Scenes/spore_monument.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/spore_monument.png"),
		"SpriteOffset": Vector2(0,-6.5),
		"Description": "KEY_BUILDING_SPORE_MONUMENT",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:spore_trophy",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_godot_plush": {
		"ObjectName": "Godot Plush",
		"ObjectPath": "res://Scenes/godot_plush.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/godot_plush.png"),
		"Description": "KEY_BUILDING_GODOT_PLUSH",
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_mover": {
		"ObjectName": "Mover",
		"ObjectPath": "res://Scenes/mover.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/mover_preview_down.png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/mover_preview_down.png"),
			load("res://Sprites/mover_preview_left.png"),
			load("res://Sprites/mover_preview_up.png"),
			load("res://Sprites/mover_preview_right.png")
		],
		
		"CanRotate": true,
		"Description": "KEY_BUILDING_MOVER",
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 3,
			},
		]
	},
	
	"starground:building_long_range_mover": {
		"ObjectName": "Long Range Mover",
		"ObjectPath": "res://Scenes/mover_long.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/mover_long_preview_down.png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/mover_long_preview_down.png"),
			load("res://Sprites/mover_long_preview_left.png"),
			load("res://Sprites/mover_long_preview_up.png"),
			load("res://Sprites/mover_long_preview_right.png")
		],
		
		"SpriteOffset": Vector2(0,0),
		"CanRotate": true,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_LONG_RANGE_MOVER",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 3,
			},
			
			{
				"ID": "starground:copper_wire",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_conveyor": {
		"ObjectName": "Conveyor",
		"ObjectPath": "res://Scenes/conveyor.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/conveyor.png"),
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_CONVEYOR",
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_underground_conveyor": {
		"ObjectName": "Underground Conveyor",
		"ObjectPath": "res://Scenes/underground_conveyor.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/underground_conveyor_entrance_preview_(0, 1).png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/underground_conveyor_entrance_preview_(0, 1).png"),
			load("res://Sprites/underground_conveyor_entrance_preview_(-1, 0).png"),
			load("res://Sprites/underground_conveyor_entrance_preview_(0, -1).png"),
			load("res://Sprites/underground_conveyor_entrance_preview_(1, 0).png"),
		],
		
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_UNDERGROUND_CONVEYOR",
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_underground_conveyor_v2": {
		"ObjectName": "Underground Conveyor V2",
		"ObjectPath": "res://Scenes/underground_conveyor_v2.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/underground_conveyor_v2_entrance_preview_(0, 1).png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/underground_conveyor_v2_entrance_preview_(0, 1).png"),
			load("res://Sprites/underground_conveyor_v2_entrance_preview_(-1, 0).png"),
			load("res://Sprites/underground_conveyor_v2_entrance_preview_(0, -1).png"),
			load("res://Sprites/underground_conveyor_v2_entrance_preview_(1, 0).png"),
		],
		
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_UNDERGROUND_CONVEYOR_V2",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:processor",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_conveyor_v2": {
		"ObjectName": "Conveyor V2",
		"ObjectPath": "res://Scenes/conveyor_v2.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/conveyor_v2.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_CONVEYOR_V2",
		"PowerStatus": 0,
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 1,
			},
			{
				"ID": "starground:gear",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_starlauncher": {
		"ObjectName": "Starlauncher",
		"ObjectPath": "res://Scenes/spaceship.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/starlauncher_preview.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_STARLAUNCHER",
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 20,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
		]
	},
	
	"starground:building_chest": {
		"ObjectName": "Chest",
		"ObjectPath": "res://Scenes/chest.tscn",
		"Sprite": load("res://Sprites/chest.png"),
		"Description": "KEY_BUILDING_CHEST",
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:stone",
				"Amount": 5,
			},
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_storage_hub": {
		"ObjectName": "Storage Hub",
		"ObjectPath": "res://Scenes/storage_hub.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/storage_hub.png"),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_STORAGE_HUB",
		"PowerStatus": 0,
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 20,
			},
		]
	},
	
	"starground:building_big_chest": {
		"ObjectName": "Big Chest",
		"ObjectPath": "res://Scenes/big_chest.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/big_chest.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_BIG_CHEST",
		"PowerStatus": 0,
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_speaker": {
		"ObjectName": "Speaker",
		"ObjectPath": "res://Scenes/speaker.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/speaker.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_SPEAKER",
		"PowerStatus": 0,
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:iron_ingot",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_stone_wall": {
		"ObjectName": "Stone Wall",
		"ObjectPath": "res://Scenes/stone_wall.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/stone_wall_side.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_STONE_WALL",
		"PowerStatus": 0,
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:stone",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_pressure_pump": {
		"ObjectName": "Pressure Pump",
		"ObjectPath": "res://Scenes/pressure_pump.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/pressure_pump.png"),
		"Description": "KEY_BUILDING_PRESSURE_PUMP",
		"PowerStatus": 0,
		"BuildingCategory": "Miscellaneous",
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
			{
				"ID": "starground:rotor",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_pressure_wall": {
		"ObjectName": "Pressure Wall",
		"ObjectPath": "res://Scenes/pressure_wall.tscn",
		"ObjectSize": Vector2(1,3),
		"Sprite": load("res://Sprites/pressure_wall_side.png"),
		"Description": "KEY_BUILDING_PRESSURE_WALL",
		"BuildingCategory": "Miscellaneous",
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_pressure_airlock": {
		"ObjectName": "Pressure Airlock",
		"ObjectPath": "res://Scenes/pressure_airlock.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/pressure_airlock.png"),
		"CanRotate": true,
		
		"SpriteArray": [
			load("res://Sprites/pressure_airlock.png"),
			load("res://Sprites/pressure_airlock_side.png"),
			load("res://Sprites/pressure_airlock.png"),
			load("res://Sprites/pressure_airlock_side.png"),
		],
		
		"Description": "KEY_BUILDING_PRESSURE_AIRLOCK",
		"BuildingCategory": "Miscellaneous",
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_pressure_storage_interface": {
		"ObjectName": "Pressure Storage Interface",
		"ObjectPath": "res://Scenes/pressure_storage_interface.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/pressure_storage_interface.png"),
		"Description": "KEY_BUILDING_PRESSURE_STORAGE_INTERFACE",
		"BuildingCategory": "Miscellaneous",
		
		"CanRotate": true,
		
		"SpriteArray": [
			load("res://Sprites/pressure_storage_interface.png"),
			load("res://Sprites/pressure_storage_interface_side.png"),
			load("res://Sprites/pressure_storage_interface.png"),
			load("res://Sprites/pressure_storage_interface_side.png"),
		],
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_lamp": {
		"ObjectName": "Lamp",
		"ObjectPath": "res://Scenes/lamp.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/lamp.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_LAMP",
		"PowerStatus": -1,
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 2,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_splitter": {
		"ObjectName": "Splitter",
		"ObjectPath": "res://Scenes/splitter.tscn",
		"ObjectSize": Vector2(2,1),
		"Sprite": load("res://Sprites/splitter_preview_down.png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/splitter_preview_down.png"),
			load("res://Sprites/splitter_preview_left.png"),
			load("res://Sprites/splitter_preview_up.png"),
			load("res://Sprites/splitter_preview_right.png")
		],
		
		"SpriteOffset": Vector2(0,0),
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_SPLITTER",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:copper_wire",
				"Amount": 4,
			},
			{
				"ID": "starground:gear",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_splitter_v2": {
		"ObjectName": "Splitter V2",
		"ObjectPath": "res://Scenes/splitter_v2.tscn",
		"ObjectSize": Vector2(2,1),
		"Sprite": load("res://Sprites/splitter_v2_preview_down.png"),
		"BuildingCategory": "Logistics",
		
		"SpriteArray": [
			load("res://Sprites/splitter_v2_preview_down.png"),
			load("res://Sprites/splitter_v2_preview_left.png"),
			load("res://Sprites/splitter_v2_preview_up.png"),
			load("res://Sprites/splitter_v2_preview_right.png")
		],
		
		"SpriteOffset": Vector2(0,0),
		"CanRotate": true,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_SPLITTER",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:processor",
				"Amount": 5,
			},
			{
				"ID": "starground:gear",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_tool_bench": {
		"ObjectName": "Tool Bench",
		"ObjectPath": "res://Scenes/tool_bench.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/tool_bench.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_TOOL_BENCH",
		"PowerStatus": 0,
		
		"Ingredients": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 2,
			},
			{
				"ID": "starground:wood",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_shredder": {
		"ObjectName": "Shredder",
		"ObjectPath": "res://Scenes/shredder.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/shredder.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_SHREDDER",
		"PowerStatus": -3,
		"BuildingCategory": "Logistics",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
			{
				"ID": "starground:gear",
				"Amount": 3,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_burner": {
		"ObjectName": "Burner",
		"ObjectPath": "res://Scenes/burner.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/burner.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,-5),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_BURNER",
		"PowerStatus": 20,
		"UsesFuel": true,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_beach_ball": {
		"ObjectName": "Beach Ball",
		"ObjectPath": "res://Scenes/pongball.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/beachball.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_BEACH_BALL",
		"PowerStatus": 0,
		"BuildingCategory": "Decorations",
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_rubber_ducky": {
		"ObjectName": "Rubber Ducky",
		"ObjectPath": "res://Scenes/rubber_ducky.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/rubber_ducky.png"),
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_RUBBER_DUCKY",
		"BuildingCategory": "Decorations",
		"CanPlaceLand": true,
		"CanPlaceWater": true,
		
		"Ingredients": [
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_computer": {
		"ObjectName": "Computer",
		"ObjectPath": "res://Scenes/computer.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/computer.png"),
		"CanRotate": false,
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_COMPUTER",
		"PowerStatus": -5,
		"BuildingCategory": "Miscellaneous",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:processor",
				"Amount": 4,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 4,
			}
		]
	},

	"starground:building_tesla_coil": {
		"ObjectName": "Tesla Coil",
		"ObjectPath": "res://Scenes/tesla_coil.tscn",
		"Sprite": load("res://Sprites/tesla_coil.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_TESLA_COIL",
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 1,
			},
			{
				"ID": "starground:stone",
				"Amount": 1,
			},
		]
	},
	
	"starground:building_tesla_coil_v2": {
		"ObjectName": "Tesla Coil V2",
		"ObjectPath": "res://Scenes/tesla_coil_v2.tscn",
		"Sprite": load("res://Sprites/tesla_coil_v2.png"),
		"SpriteOffset": Vector2(0,-8),
		"Description": "KEY_BUILDING_TESLA_COIL",
		"BuildingCategory": "Power",
		"CanPlaceWater": true,
		"CanPlaceLand": true,
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 2,
			},
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 2,
			},
		]
	},
	
	"starground:building_solar_panel": {
		"ObjectName": "Solar Panel",
		"ObjectPath": "res://Scenes/solar_panel.tscn",
		"ObjectSize": Vector2(3,3),
		"Sprite": load("res://Sprites/solar_panel.png"),
		"PlayerCollision": false,
		"Description": "KEY_BUILDING_SOLAR_PANEL",
		"PowerStatus": 10,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:steel",
				"Amount": 5,
			},
			{
				"ID": "starground:processor",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
		]
	},

	"starground:building_battery": {
		"ObjectName": "Battery",
		"ObjectPath": "res://Scenes/battery.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/battery.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_BATTERY",
		"PowerStatus": 0,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_big_battery": {
		"ObjectName": "Big Battery",
		"ObjectPath": "res://Scenes/big_battery.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/big_battery.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_BIG_BATTERY",
		"PowerStatus": 0,
		"BuildingCategory": "Power",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:copper_wire",
				"Amount": 10,
			},
			{
				"ID": "starground:steel",
				"Amount": 5,
			},
		]
	},
	
	"starground:building_space_elevator": {
		"ObjectName": "Space Elevator",
		"ObjectPath": "res://Scenes/space_elevator.tscn",
		"ObjectSize": Vector2(6,6),
		"Sprite": load("res://Sprites/space_elevator.png"),
		"SpriteOffset": Vector2(0,-96),
		"Description": "KEY_BUILDING_SPACE_ELEVATOR",
		"PowerStatus": -40,
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 30,
			},
			{
				"ID": "starground:depleted_uranium",
				"Amount": 15,
			},
			{
				"ID": "starground:rotor",
				"Amount": 10,
			},
			{
				"ID": "starground:processor",
				"Amount": 10,
			},
			{
				"ID": "starground:steel",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_vault": {
		"ObjectName": "Vault",
		"ObjectPath": "res://Scenes/vault.tscn",
		"ObjectSize": Vector2(2,2),
		"Sprite": load("res://Sprites/vault.png"),
		"SpriteArray": [],
		"SpriteOffset": Vector2(0,0),
		"CanRotate": false,
		"PlayerCollision": true,
		"Description": "KEY_BUILDING_VAULT",
		"PowerStatus": 0,
		"BuildingCategory": "Logistics",
		
		"Ingredients": [
			{
				"ID": "starground:steel",
				"Amount": 10,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
		]
	},
	
	"starground:building_grinder": {
		"ObjectName": "Grinder",
		"ObjectPath": "res://Scenes/grinder.tscn",
		"ObjectSize": Vector2(3,2),
		"Sprite": load("res://Sprites/grinder.png"),
		"Description": "KEY_BUILDING_GRINDER",
		"PowerStatus": -10,
		"BuildingCategory": "Production",
		"Waterproof": false,
		
		"Ingredients": [
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
			{
				"ID": "starground:gear",
				"Amount": 3,
			},
			{
				"ID": "starground:copper_wire",
				"Amount": 4,
			},
		]
	},
}
