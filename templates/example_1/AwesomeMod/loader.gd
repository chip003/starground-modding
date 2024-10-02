extends Node

func _init() -> void:
	## The init function is where you can integrate your mod content
	
	## Adding an item
	var funnyItem = ModAPI.create_item_entry("bbg_templatemod:item_funny_item", "Funny Item", load("res://Sprites/Items/funny_item_example.png"), [])
	ModAPI.add_item_entry(funnyItem)
	
	## Adding a building
	var buildingEntry = {
		"ObjectName": "Funny Building",
		"ObjectPath": "res://Scenes/funny_building.tscn",
		"ObjectSize": Vector2(1,1),
		"Sprite": load("res://Sprites/mod_building_example.png"),
		"Description": "A kneeslapper of a mod building!",
		"Ingredients": [
			{
				"ID": "bbg_templatemod:item_funny_item",
				"Amount": 2,
			},
		]
	}
	ModAPI.add_building_entry("bbg_templatemod:building_funny", buildingEntry)
	
	## Making sure the funny building syncs on multiplayer
	ModAPI.add_spawner_entry("res://Scenes/funny_building.tscn")
	
	#ModAPI.add_loot_entry("starground:loot_resource_nodes", [8, load("res://Scenes/uranium_rock.tscn")])
