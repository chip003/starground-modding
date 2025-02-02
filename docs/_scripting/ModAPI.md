# The ModAPI Class
This is the class in which you interface for the default elements of the game. This is a core component to making a mod.

## Best Practices
>A lot of these functions will use an ID parameter.
>    This is a unique String that should be formatted as `'mod_id:unique_entry_id'`
> 
>It's highly recommended to add all items, buildings, loot tables, or other similar things to reference tables. This lets you easily access your own modded things, but plays nicely alongside other mods.

## Buildings Methods
Buildings are defined through a building dictionary entry. These contain many option keys you can find more information about keys [here](_scripting/Data-Tables-and-Their-Tags.md).

Below is an example of a building entry.
```gdscript
{
	"ObjectName": "Chest",
	"ObjectPath": "res://Scenes/chest.tscn",
	"ObjectSize": Vector2(1,1),
	"Sprite": load("res://Sprites/chest.png"),
	"Description": "A place to store all your items.",
	"Ingredients": [
		{
			"ID": "starground:wood",
			"Amount": 5,
		},
	]
},
```


### Add Building Entry
How to use the `add_building_entry` method and a overview of its parameters is below.

| Parameters   | Description of Variable                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------- |
| buildingID   | A unique ID for a building                                                                        |
| entry        | A dictionary with building info (see above for example)                                           |

```gdscript
ModAPI.add_building_entry(buildingID, entry)
```


## Research Methods
Research is defined through a research dictionary. There are three types of research implemented into the game. See table below.

| Type     | Description                                                                                                                                                                        |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| INFINITE | A type of research that can be continually researched to increase an effect. Requires `costMultiplier` and `effectIncrement` custom tags.                                          |
| SINGLE   | A basic type that takes in ingredients, and unlocks a set of specific things.                                                                                                      |
| TIERED   | A hybrid between infinite and single, that takes in different items at each level of research. Not infinite, but also requires `costMultiplier` and `effectIncrement` custom tags. |

*The above are defined within the `RESEARCH_TYPES` enum found within the `Global` class.  Don't forget the special differences between research types!*

Below is an example of a defined Research entry.
```gdscript
"starground:research_clean_energy": {
	"Name": "Clean Energy",
	"Input": [
		{
			"ID": "starground:steel",
			"Amount": 40,
		},
	],
	"Unlocks": [
		"starground:building_solar_panel",
		"starground:building_big_battery",
	]
},
```

### Create Research Entry
Below is example on how to use the `create_research_entry` method and explaining of the required parameters.

```gdscript
ModAPI.create_research_entry(researchID, researchName, inputItems, unlocks, specialTags)
```

| Parameter    | Description of Parameter                                                                                                   |
| ------------ | -------------------------------------------------------------------------------------------------------------------------- |
| researchID   | Should be a unique ID that never changes                                                                                   |
| researchName | The display name of the research                                                                                           |
| inputItems   | An array filled with the required item dictionaries (E.x. `{ID: "starground:wood", "Amount": 5})`                          |
| unlocks      | An array filled with either item or building IDs to be unlocked (E.x. `["starground:building_chest", "starground:steel"]`) |
| specialTags  | An array filled with dictionaries of special tags (E.x. `[{"Type": Global.}, {"Requires": []}]`)                           |

### Add Research Entry
Below is example on how to use the `add_research_entry` method and explaining of the required parameters.

```gdscript
ModAPI.add_research_entry(researchID, entry)
```

| Parameter  | Description of Parameter                                                  |
| ---------- | ------------------------------------------------------------------------- |
| researchID | A unique ID for a research (E.x. `starground:research_better_automation`) |
| entry      | A dictionary with research info (see above for example)                   |

## Item Methods
Add some information about the structure of a defined item for reference within the `item_table`.

### Create Item Entry
Below is example on how to use the `create_item_entry` method and explaining of the required parameters.

```gdscript
ModAPI.create_item_entry(ID, Name, Sprite, specialTags)
```

| Parameter  | Description of Parameter                                                                 |
| ---------- | ---------------------------------------------------------------------------------------- |
| ID         | Should be a unique ID that never changes                                                 |
| Name       | The display name of the item                                                             |
| Sprite     | A loaded sprite resource for the item                                                    |
| customTags | An array filled with dictionaries of special tags (E.x. `[{"Damage": 10}, {"Heal": 5}]`) |

### Add Item Entry
Below is example on how to use the `add_item_entry` method and explaining of the required parameters.

```gdscript
ModAPI.add_item_entry(entry)
```

| Parameter | Description of Parameter                             |
| --------- | ---------------------------------------------------- |
| entry     | A dictionary populated with the correct data entries |

## Effect Methods
Add some information about the structure of a defined item for reference within the `effects_table`.

### Create Effect Entry
Below is example on how to use the `create_effect_entry` method and explaining of the required parameters.

```gdscript
ModAPI.create_effect_entry(ffectID, effectName, effectScriptPath)
```

| Parameter        | Description of Parameter                                                            |
| ---------------- | ----------------------------------------------------------------------------------- |
| effectID         | A unique ID for an effect (E.x. `starground:effect_poison`)                         |
| effectName       | The name for an effect (E.x. `Poison`)                                              |
| effectScriptPath | The path for a script resource to be ran (E.x. `res://Resources/Effects/poison.gd`) |

### Add Effect Entry
Below is example on how to use the `add_effect_entry` method and explaining of the required parameters.

```
ModAPI.add_effect_entry(entry)
```

| Parameter | Description of Parameter                                                      |
| --------- | ----------------------------------------------------------------------------- |
| entry     | An effect data dictionary (recommended to make this with create_effect_entry) |

## Multiplayer Methods
Methods below were made to better support multiplayer within mods.

### Add Spawner Entry
A function to add scenes into the multiplayer spawner. This is necessary to have nodes appear for the host and client on multiplayer!

```gdscript
ModAPI.add_spawner_entry(resourcePath)
```

| Parameter    | Description of Parameter                                 |
| ------------ | -------------------------------------------------------- |
| resourcePath | A string filepath to the scene to be spawned for clients |

### Add UI Spawner Entry
A function to add UI into the multiplayer spawner. This is necessary to have UI properly work on multiplayer!

```gdscript
ModAPI.add_ui_spawner_entry(resourcePath)
```

| Parameter    | Description of Parameter                                 |
| ------------ | -------------------------------------------------------- |
| resourcePath | A string filepath to the scene to be spawned for clients |

## Misc Methods
Below is a list of functions that do not have a main topic. 

### Add Cache Entry
A function to add stuff into the list of scenes or resources to be loaded on startup. This is recommended to improve load times and general performance.

```gdscript
ModAPI.add_cache_entry(resourcePath)
```

| Parameter | Description of Parameter                        |
| --------- | ----------------------------------------------- |
| resource  |  A string filepath to the resource to be cached |

### Add Loot Entry
This function will add an entry to a loot table. Loot tables can be formatted differently, so make sure you're following the right format! *Entries with the same name will overwrite pre-existing ones*

```gdscript
ModAPI.add_loot_entry(lootID, entry)
```

| Parameter | Description of Parameter                                                                         |
| --------- | ------------------------------------------------------------------------------------------------ |
| lootID    | An ID for what loot table is being modified                                                      |
| entry     | A new data entry (typically an array formatted with weight first, and a string or resource next) |

### Choose Weighted Loot
This function will return a loot entry, taking into account its weighted values.

```gdscript
ModAPI.choose_weighted_loot(lootID)
```

| Parameter | Description of Parameter                    |
| --------- | ------------------------------------------- |
| lootID    | An ID for what loot table is being accessed |
