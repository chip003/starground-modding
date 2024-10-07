# Data Tables
Starground has multiple data tables that modders can access. Functions to add resources to these can be found in the ModAPI class. Anything that CAN be placed into one of these tables, NEEDS to.

These all contain IDs with data entries that the game uses to read data. These tables include:

| Table Type      | Description                                                                  |
| --------------- | ---------------------------------------------------------------------------- |
| Items Table     | Contains entries for items.                                                  |
| Buildings Table | Contains entries for buildings                                               |
| Effects Table   | Contains entries for effects (statuses applied to entities).                 |
| Loot Table      | Contains arrays for loot tables that are used in various locations in-game.  |
| Recipe Table    | Contains all recipes for buildings.                                          |
| Spawner Table   | Contains filepaths for buildings to be spawned for clients (for multiplayer) |
| Caching Table   | Loads filepaths on game loading to improve performance                       |

You can find the tags that each table type can contain below.


##  Table Tags

Starground contains many types of tags for items and buildings, and these can change how they behave in-game. All tags are entries in a dictionary, with each tag being formatted as `"TagName": entry`.

### Items
| Tag                  | Required | Description                                                                                                                                |
| -------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Name (String)        | true     | The name that is displayed for an item.                                                                                                    |
| Sprite (Object)      | true     | A sprite that is loaded in with `load(file_path)`                                                                                          |
|                      |          |                                                                                                                                            |
| StackSize (int)      | false    | Changes the maximum stack size for inventories.                                                                                            |
| Artifact (bool)      | false    | A tag to denote whether an item is an artifact or not. Will change the appearance of slots.                                                |
| Description (String) | false    | A tag to add a description to an item that is displayed when hovered over.                                                                 |
| Fuel (float)         | false    | A tag to mark an item as being a fuel source, and holding a float value of how many seconds it lasts for.                                  |
| Heart (bool)         | false    | Whether an item is a heart (only used in extremely special cases).                                                                         |
| Heal (float)         | false    | How much an item will heal the player when consumed.                                                                                       |
| Farmable (bool)      | false    | Makes an item display that it's farmable when hovered over.                                                                                |
| Effect (Dictionary)  | false    | Contains a dictionary with an effect ID and length (seconds) for when it is consumed. (e.x. `{"ID": "starground:poison", "Length": 10.0}`) |


### Weapon Tags

| Tag                 | Required | Description                                                                                                           |
| ------------------- | -------- | --------------------------------------------------------------------------------------------------------------------- |
| Damage (float)      | false    | How much damage an item does when placed in a weapon.                                                                 |
| Cooldown (float)    | false    | How an item affects weapon cooldown (can be negative or positive).                                                    |
| Knockback (Vector2) | false    | How an item affects weapon knockback.                                                                                 |
| Reach (float)       | false    | A number to display reach (likely will be removed soon).                                                              |
| SelfDamage (bool)   | false    | Whether or not an item being held in a player's hand deals damage to themselves.                                      |
| DamageType (Enum)   | false    | What kind of damage a weapon deals. Can be accessed as Global.DAMAGE.SHARP, with damage being SHARP, BLUNT, or MAGIC. |

### Buildings


| Tag                        | Required | Description                                                                                                                                      |
| -------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| ObjectName (String)        | true     | The name that is displayed for a building.                                                                                                       |
| ObjectPath (String)        | true     | A filepath pointing to the object's scene.                                                                                                       |
| ObjectSize (Vector2)       | true     | A Vector2 specifying an object's size in tiles (e.x. a chest has a size of `Vector2(1,1)`).                                                      |
| Sprite (Object)            | true     | A sprite preview that is loaded in with `load(file_path)`.                                                                                       |
| Description (String)       | true     | A description for a building.                                                                                                                    |
| Ingredients (Array)        | true     | An array filled with item dictionaries of what is required to build a building (e.x. `"Ingredients": [{"ID": "starground:stone", "Amount": 10}]` |
|                            |          |                                                                                                                                                  |
| UsesFuel (bool)            | false    | Whether or not a building uses fuel.                                                                                                             |
| BuildingsCategory (String) | false    | Which building category a building will be placed into in the buildings menu.                                                                    |
| CanPlaceLand (bool)        | false    | Whether or not a building can be placed on land.                                                                                                 |
| CanPlaceWater (bool)       | false    | Whether or not a building can be placed on water.                                                                                                |
| PowerStatus (float)        | false    | How much power a building uses. Positive for power generation, and negative for power consumption.                                               |
| PlayerCollision (bool)     | false    | Whether or not a building can be placed onto players.                                                                                            |
| SpriteArray (Array)        | false    | An array for rotating buildings like Movers. Requires 4 loaded image sprites for each rotation.                                                  |
| SpriteOffset (Vector2)     | false    | An offset to display the preview image when building a building.                                                                                 |
| CanRotate (bool)           | false    | Whether or not a building can be rotated with `R` Key.                                                                                           |

### Research


| Tag              | Required | Description                                                                                                                                                                                                                                                                        |
| ---------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Name (String)    | true     | Name that is displayed for the research.                                                                                                                                                                                                                                           |
| Input (Array)    | true     | An array of items that are required for a research (e.x. `"Input": {"ID": "starground:gear", "Amount": 20}]`                                                                                                                                                                       |
| Unlocks (Array)  | true     | An array of IDs for what things are unlocked when a research is completed. Can contain items (for recipes) or buildings (e.x. `"Unlocks": ["starground:building_conveyor_v2", "starground:steel"])`                                                                                |
|                  |          |                                                                                                                                                                                                                                                                                    |
| Requires (Array) | false    | A list of research IDs that are required for a research until it can be selected.                                                                                                                                                                                                  |
| Type (Enum)      | false    | Denotes what kind of research. Uses `Global.RESEARCH_TYPES`. Can use `RESEARCH_TYPES.SINGLE` (one-time research), `RESEARCH_TYPES.INFINITE` (infinite research), or `RESEARCH_TYPES.TIERED` (a combo between single and infinite that requires different materials at each level). |
#### Infinite Research Tags

| Tag                     | Required | Description                                                                                                               |
| ----------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------- |
| CostMultiplier (float)  | false    | A cost multiplier that will be applied to the input items for each level (Ex. level 5 will cost `Amount*(multiplier^5)` ) |
| EffectIncrement (float) | false    | A value that will increment for each level (Ex. level 5 will have an increment of 1)                                      |

##### Tiered Research Tags

| Tag                     | Required | Description                                                                                                                                                                                                  |
| ----------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| EffectIncrement (float) | false    | Same as `EffectIncrement` for Infinite Research                                                                                                                                                              |
| Input (Array)           | false    |  Input works mainly the same way, except instead of items, now the array holds arrays of input items for each level of research. So level 1 will access the first array, level 2 will access the second etc. |
