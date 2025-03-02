extends Node

## Welcome to the ModAPI script!

## Script Version: v1.9

# This is a helper script to make modding a lot easier, and to prevent conflicts with other mods.
# You should always use these functions if they fulfill what you need to do.
# Read through all functions below to see what they do (odds are you'll need them!)

# If you have things that should be added here, or run into issues, let Jesse know!

#TODO: integrate Global functions into ModAPI

##---------------BEST PRACTICES---------------##
# A lot of these functions will use an ID parameter
# This is a unique String that should be formatted as 'mod_id:unique_entry_id'

# It's highly recommended to add all items, buildings, loot tables, or other similar things to reference tables using the 'add' functions
# This lets you easily access your own modded things, but plays nicely alongside other mods too

#region VARIABLES ------------------------------------
enum RESEARCH_TYPES {INFINITE, SINGLE, TIERED} #Categories for research
enum DAMAGE {SHARP, BLUNT, MAGIC} #Not used yet, but hopefully soon
enum REGION {AUTOMATION, SPACE, DUNGEON} #General categories for different regions
#endregion


#region ADD FUNCTIONS ---------------
## Add functions are for integrating your content into the game, by adding them to data tables

## Buildings are defined through a building dictionary entry. These contain many optional keys, but the bare minimum is shown below:

#{
	#"ObjectName": "Chest",
	#"ObjectPath": "res://Scenes/chest.tscn",
	#"ObjectSize": Vector2(1,1),
	#"Sprite": load("res://Sprites/chest.png"),
	#"Description": "A place to store all your items.",
	#"Ingredients": [
		#{
			#"ID": "starground:wood",
			#"Amount": 5,
		#},
	#]
#},

## Adds a building entry to the buildings table.
# buildingID | A unique ID for a building
# entry      | A dictionary with building info (see above for example)
func add_building_entry(buildingID : String, entry : Dictionary) -> void:
	Global.buildingsTable.merge({buildingID: entry}, true)


## A function to add an effect entry to the effects table.
# ID    | A unique ID for an effect
# entry | An effect data dictionary (recommended to make this with create_effect_entry)
func add_effect_entry(effectID : String, entry : Dictionary) -> void:
	Global.effectsTable.merge({effectID: entry}, true)


## A function to add a shop entry to the shop table.
# shopID | A unique ID for a shopkeeper (e.x. starground:shop_bissala)
# entry  | A shop data dictionary
func add_shop_entry(shopID : String, entry : Dictionary) -> void:
	Global.shopTable.merge({shopID: entry}, true)
	

## A function to add a recipe entry to the recipe table.
# buildingID | A unique ID for a building to attach a recipe to (e.x. starground:building_crafter)
# recipeID   | A unique ID for a building's recipe (e.x. starground:recipe_strength_potion)
# entry      | A recipe data dictionary
func add_recipe_entry(buildingID : String, recipeID : String, entry : Dictionary) -> void:
	if Global.recipeTable.has(buildingID):
		Global.recipeTable[buildingID].merge({recipeID: entry}, true)
	else:
		Global.recipeTable[buildingID] = {recipeID: entry}


## A function to add a region entry to the regions table.
# regionID | A unique ID for a region (e.x. starground:region_veridian)
# entry    | A region data dictionary
func add_region_entry(regionID : String, entry : Dictionary) -> void:
	Global.regionsTable.merge({regionID: entry}, true)


## Adds a research entry to the research table.
# researchID | A unique ID for a research (e.x. starground:research_better_automation)
# entry      | A dictionary with research info (see above for example)
func add_research_entry(researchID : String, entry : Dictionary) -> void:
	Global.researchTable.merge({researchID: entry}, true)


## Indexes an item from a dictionary (highly recommended to use create_item_entry() for this)
## Entries with the same name will overwrite pre-existing ones
# itemID | A unique ID for an item (e.x. starground:wood)
# entry  | A dictionary populated with the correct data entries
func add_item_entry(itemID : String, entry : Dictionary) -> void:
	Global.itemsTable.merge({itemID: entry}, true)


## A function to add stuff into the list of scenes or resources to be loaded on startup.
## This is recommended to improve load times and general performance.
# resource | A string filepath to the resource to be cached
func add_cache_entry(resourcePath : String) -> void:
	Global.cacheTable.push_back(resourcePath)


## This function will add an entry to a loot table
## Loot tables can be formatted differently, so make sure you're following the right format!
## Entries with the same name will overwrite pre-existing ones
# lootID | An ID for what loot table is being modified (e.x. starground:loot_dreadcap)
# entry  | A new data entry (typically an array formatted with weight first, and a string or resource next)
func add_loot_entry(lootID : String, entry : Array) -> void:
	if Global.lootTable.has(lootID):
		Global.lootTable[lootID].push_back(entry)
	else:
		Global.lootTable[lootID] = [entry]


## This function will add a scene to the player's UI Canvas node
## All UI is a child of the Canvas node, which is a child of the player
## The owner variable will be set to the player on instantiation
## UI is added on both the server and client (for data transmission), so be aware of what needs to be enabled/disabled
## ! add_ui_spawner_entry() is not needed for player UI !
# scenePath | A path to the scene that will be added to player UI
func add_player_ui(scenePath) -> void:
	Global.playerUIScenes.push_back(scenePath)


## A function to add scenes into the multiplayer spawner.
## This is necessary to have nodes appear for the host and client on multiplayer!
# resourcePath | A string filepath to the scene to be spawned for clients
func add_spawner_entry(resourcePath : String) -> void:
	Global.spawnerTable.push_back(resourcePath)
	
	
## A function to add UI into the multiplayer spawner
## This is necessary to have UI properly work on multiplayer!
# resourcePath | A string filepath to the resource to be spawned for clients
func add_ui_spawner_entry(resourcePath : String) -> void:
	Global.uiSpawnerTable.push_back(resourcePath)
	
	
## This function will add a command to the list
# command | The string to run your command (e.x. /give)
# entry   | A path to your command script (see other command scripts on how to set them up)
func add_command(command : String, scriptPath : String) -> void:
	Global.commandsTable.merge({command: {"Resource": scriptPath}}, true)

#endregion


#region CREATE FUNCTIONS -----------------
## Create functions are for creating dictionaries and other data structures with a function.
## Note that some types of data structures are too large and specific to be reasonably created in a function


## Research is defined through a research dictionary. 

## Research has three types using this enum: RESEARCH_TYPES {INFINITE, SINGLE, TIERED}
# INFINITE | A type of research that can be continually researched to increase an effect. Requires costMultiplier and effectIncrement customTags
# SINGLE   | A basic type that takes in ingredients, and unlocks a set of specific things.
# TIERED   | A hybrid between infinite and single, that takes in different items at each level of research.
#			 Not infinite, but also requires costMultiplier and effectIncrement customTags.

## To add a type, add the following key: "Type": Global.RESEARCH_TYPES.INFINITE
## Don't forget the special differences between research types!

## Below is an example of the bare minimum, but check the research table for other examples:

#"starground:research_clean_energy": {
	#"Name": "Clean Energy",
	#"Input": [
		#{
			#"ID": "starground:steel",
			#"Amount": 40,
		#},
	#],
	#"Unlocks": [
		#"starground:building_solar_panel",
		#"starground:building_big_battery",
	#]
#},

## Creates a research entry
# researchName | The display name of the research
# inputItems   | An array filled with the required item dictionaries (e.x. {ID: "starground:wood", "Amount": 5})
# unlocks	   | An array filled with either item or building IDs to be unlocked (e.x. ["starground:building_chest", "starground:steel"])
# specialTags  | A dictionary filled with special tags (e.x. {"Type": Global, "Requires": []})
#			   | You should check guides or ask Jesse what vanilla tags you can use!
func create_research_entry(researchName : String, inputItems : Array, unlocks : Array, specialTags : Dictionary) -> Dictionary:
	var entry : Dictionary = {
		"Name": researchName,
		"Input": inputItems,
		"Unlocks": unlocks,
	}
	
	entry.merge(specialTags)
	
	return entry


## A function to create an item dictonary
## These are what is stored inside of inventories and other containers
## They only need the ID, amount, and held status (for multiplayer).
## Other info like images, stacksize etc. can be grabbed with get_item_info()
## ! THIS SHOULD NOT BE PASSED INTO ADD_ITEM_ENTRY !
# itemID | A unique ID for an item (e.x. starground:wood)
# amount | How many of the item there is
func create_item_dict(itemID : String, amount : int):
	return {
		"ID": itemID,
		"Amount": amount,
		"Held": false,
	}


## A function to create an effect entry to be used with add_effect_entry().
# effectName 	   | The name for an effect (e.x. Poison)
# effectScriptPath | The path for a script resource to be ran (e.x. res://Resources/Effects/poison.gd)
func create_effect_entry(effectName, effectScriptPath) -> Dictionary:
	var entry : Dictionary = {
		"Name": effectName,
		"Resource": effectScriptPath,
	}
	
	return entry


## Creates and returns a dictionary for an item from an ID, Name, and Sprite.
## This is only used to add item data to the items table.
# Name   	  | The display name of the item
# Sprite 	  | A loaded sprite resource for the item
# specialTags | A dictionary filled with special tags (e.x. {"Damage": 10, "Heal": 5})
#			  | You should check guides or ask Jesse what vanilla tags you can use!
func create_item_entry(Name : String, Sprite : Object, specialTags : Dictionary = {}) -> Dictionary:
	var entry : Dictionary = {
		"Name": Name,
		"Sprite": Sprite,
	}
	
	entry.merge(specialTags)
	
	return entry
#endregion


#region HELPER FUNCTIONS ------------------------------------
## Returns a sin value between a min and max number
func sin_range(minNum : float, maxNum : float, t : float) -> float:
	var halfRange : float = (maxNum - minNum)/2.0
	return minNum + halfRange + sin(t) * halfRange


## Returns a reference to the closest player
func get_closest_player_target(position : Vector2) -> Variant:
	var dist : float = INF
	var node : Variant
	
	for i in get_tree().get_nodes_in_group("Players"):
		if !i.hasDied:
			var newDist : float = position.distance_squared_to(i.global_position)
			if newDist < dist:
				node = i
				dist = newDist
	return node


## Returns a reference to the closest node of a given Group
func get_closest_node(position : Vector2, groupName : String) -> Variant:
	var dist : float = INF
	var node : Variant
	
	for i in get_tree().get_nodes_in_group(groupName):
		var newDist : float = position.distance_squared_to(i.global_position)
		if newDist < dist:
			node = i
			dist = newDist
	return node


@rpc("call_local", "any_peer")
func set_rain(rainTimer : float, rainLength : float):
	var main = get_node("/root/Multiplayer")
	main.rainTimer = rainTimer
	main.rainLength = rainLength


@rpc("call_local", "any_peer")
func set_time(time : float) -> void:
	get_node("/root/Multiplayer").time = time


## Uses slower distance_to instead of distance_squared_to
func get_closest_player_target_and_dist(position : Vector2) -> Array:
	var dist : float = INF
	var node : Variant
	
	for i in get_tree().get_nodes_in_group("Players"):
		if !i.hasDied:
			var newDist : float = position.distance_to(i.global_position)
			if newDist < dist:
				node = i
				dist = newDist
	return [node,dist]


## Probably should use .snappedf instead!
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


## A very helpful function for retrieving a dictionary of item data, given its id
func get_item_data(itemID) -> Dictionary:
	return Global.itemsTable.get(itemID, Global.itemsTable["starground:nai"])


## A function to replace resources on startup
## Good for keeping files in your own folder, but still replacing assets
# oldPath | A string filepath to the resource to be replaced
# newPath | A string filepath to the resource that is replacing the other one
func replace_path(oldPath : String, newPath : String) -> void:
	if newPath.contains("global.gd"):
		printerr("Invalid overriding of global.gd!")
		return
		
	load(newPath).take_over_path(oldPath)
	
	
## This function will return a loot entry, taking into account its weighted values
# lootID | An ID for what loot table is being accessed
func choose_weighted_loot(lootID : String, randGen : RandomNumberGenerator = RandomNumberGenerator.new()) -> Array:
	var sum : float = 0.0
	for i : Array in Global.lootTable.get(lootID):
		sum += i[0]
	
	var rand : float = randGen.randf_range(0,sum)
	
	for i : Array in Global.lootTable.get(lootID):
		if rand < i[0]:
			return i
		rand -= i[0]
	return []


## Returns region data from the closest region at a given position
func get_region_at_position(position : Vector2) -> Dictionary:
	return Global.regionsTable.get(get_region_id_at_position(position), {})
	

## Returns the id of the closest region
func get_region_id_at_position(position : Vector2) -> String:
	var dist : float = INF
	var regionID : String
	
	for i in Global.regionsTable:
		var newDist : float = position.distance_squared_to(Global.regionsTable[i].Location)
		if newDist < dist:
			dist = newDist
			regionID = i
			
	return regionID


## Returns region info given an ID
func get_region_from_id(regionID) -> Dictionary:
	var region = Global.regionsTable.get(regionID)
	return region


## Returns the closest terrain tilemap at a position
func get_tilemap_at_position(position : Vector2) -> TileMapLayer:
	var tilemap : TileMapLayer
	var selectedRegion : Dictionary = get_region_at_position(position)
	var tilemapPath = selectedRegion.get("Tilemap")
	if tilemapPath:
		tilemap = get_node_or_null("/root/Multiplayer/World/" + selectedRegion.Tilemap)
	
	return tilemap
	

## Returns a tilemap given a regionID
func get_tilemap_from_id(regionID) -> TileMapLayer:
	var tilemap : TileMapLayer
	var region = Global.regionsTable.get(regionID)
	var tilemapPath = region.get("Tilemap")
	
	if tilemapPath:
		tilemap = get_node_or_null("/root/Multiplayer/World/" + region.Tilemap)
	
	return tilemap

	
## Returns the closest decoration tilemap
func get_decoration_tilemap_at_position(position : Vector2) -> TileMapLayer:
	var tilemap : TileMapLayer
	var selectedRegion : Dictionary = get_region_at_position(position)
	tilemap = get_node("/root/Multiplayer/World/" + selectedRegion.DecorationTilemap)
	
	return tilemap
#endregion
