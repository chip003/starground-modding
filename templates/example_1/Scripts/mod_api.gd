extends Node

## Welcome to the ModAPI script!

## Script Version: v1.2

# This is a helper script to make modding a lot easier, and to prevent conflicts with other mods.
# You should always use these functions if they fulfill what you need to do.
# Read through all functions below to see what they do (odds are you'll need them!)

# If you have things that should be added here, or run into issues, let Jesse know!


#---------------BEST PRACTICES---------------#

# A lot of these functions will use an ID parameter
# This is a unique String that should be formatted as 'mod_id:unique_entry_id'

# It's highly recommended to add all items, buildings, loot tables, or other similar things to reference tables
# This lets you easily access your own modded things, but plays nicely alongside other mods too


#---------------BUILDING FUNCTIONS---------------#

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

#---------------RESEARCH FUNCTIONS---------------#

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
# researchID   | Should be a unique ID that never changes
# researchName | The display name of the research
# inputItems   | An array filled with the required item dictionaries (e.x. {ID: "starground:wood", "Amount": 5})
# unlocks	   | An array filled with either item or building IDs to be unlocked (e.x. ["starground:building_chest", "starground:steel"])
# specialTags  | An array filled with dictionaries of special tags (e.x. [{"Type": Global.}, {"Requires": []}])
#			   | You should check guides or ask Jesse what vanilla tags you can use!
func create_research_entry(researchID, researchName, inputItems, unlocks, specialTags) -> Dictionary:
	var entry = {
		researchID: {
			"Name": researchName,
			"Input": inputItems,
			"Unlocks": unlocks,
		}
	}
	
	for i in specialTags:
		entry[researchID].merge(i)
	
	return entry

## Adds a research entry to the buildings table.
# researchID | A unique ID for a research (e.x. starground:research_better_automation)
# entry      | A dictionary with research info (see above for example)
func add_research_entry(researchID : String, entry : Dictionary) -> void:
	Global.researchTable.merge({researchID: entry}, true)


#---------------ITEM FUNCTIONS---------------#

## Creates and returns a dictionary for an item from an ID, Name, and Sprite.
# ID     	 | Should be a unique ID that never changes
# Name   	 | The display name of the item
# Sprite 	 | A loaded sprite resource for the item
# customTags | An array filled with dictionaries of special tags (e.x. [{"Damage": 10}, {"Heal": 5}])
#			 | You should check guides or ask Jesse what vanilla tags you can use!
func create_item_entry(ID : String, Name : String, Sprite : Object, specialTags : Array[Dictionary] = []) -> Dictionary:
	var entry : Dictionary = {
		ID: {
			"Name": Name,
			"Sprite": Sprite,
		}
	}
	
	for i in specialTags:
		entry[ID].merge(i)
	
	return entry


## Indexes an item from a dictionary (highly recommended to use build_item_entry() for this)
## Entries with the same name will overwrite pre-existing ones
# entry | A dictionary populated with the correct data entries
func add_item_entry(entry : Dictionary) -> void:
	Global.itemsTable.merge(entry, true)


#---------------EFFECT FUNCTIONS---------------#

## A function to create an effect entry to be used with add_effect_entry().
# effectID   	   | A unique ID for an effect (e.x. starground:effect_poison)
# effectName 	   | The name for an effect (e.x. Poison)
# effectScriptPath | The path for a script resource to be ran (e.x. res://Resources/Effects/poison.gd)
func create_effect_entry(effectID : String, effectName, effectScriptPath) -> Dictionary:
	var entry : Dictionary = {
		effectID: {
			"Name": effectName,
			"Resource": effectScriptPath,
		}
	}
	
	return entry


## A function to add an effect entry to the effects table.
# entry | An effect data dictionary (recommended to make this with create_effect_entry)
func add_effect_entry(entry : Dictionary) -> void:
	Global.effectsTable.merge(entry, true)


#---------------MULTIPLAYER FUNCTIONS---------------#

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


#---------------MISC FUNCTIONS---------------#

## A function to add stuff into the list of scenes or resources to be loaded on startup.
## This is recommended to improve load times and general performance.
# resource | A string filepath to the resource to be cached
func add_cache_entry(resourcePath : String) -> void:
	Global.cacheTable.push_back(resourcePath)


## This function will add an entry to a loot table
## Loot tables can be formatted differently, so make sure you're following the right format!
## Entries with the same name will overwrite pre-existing ones
# lootID | An ID for what loot table is being modified
# entry  | A new data entry (typically an array formatted with weight first, and a string or resource next)
func add_loot_entry(lootID : String, entry : Array) -> void:
	Global.lootTable.merge({
		lootID: [entry]
	})
	
	
## This function will return a loot entry, taking into account its weighted values
# lootID | An ID for what loot table is being accessed
func choose_weighted_loot(lootID : String) -> Array:
	var sum : float = 0.0
	for i : Array in Global.lootTable.get(lootID):
		sum += i[0]
		
	var rand : float = randf_range(0,sum)
	
	for i : Array in Global.lootTable.get(lootID):
		if rand < i[0]:
			return i
		rand -= i[0]
	return []
