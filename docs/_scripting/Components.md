# Components

Components are an easy way to add specific functionality to your scenes without the hassle of inheriting tons of functions and variables from parent classes. These are all in the form of a scene that you can add as a child to your scenes (don't use the script!).

## save_component.tscn
This component is a very simple and easy way of saving your modded buildings to a game's save (files located in the saves/ folder with the .dat extension). This component will save a building's:
* Filepath
* Name
* Position
* Inventory (from inventory components)
* Custom variables (variables in the main scene's script)

To save a custom variable, add it to the Variables array in the inspector panel. This should be a string of the name of your variable.

If you don't need any special variables saved however, then it's as simple as throwing it into your scene, and your done!

## inventory_component.tscn
This component is a widely used component for handling everything related to inventories. If you're adding anything into the game that can hold items or open a UI, definitely use this component.

There's quite a few settings in the inspector. Most of them should be self-explanatory, and some of them should never be modified (for internal use only). 
### Things You Can Change
* Inventory Rows (int)
> How many rows of slots an inventory will have
* Inventory Columns (int)
> How many columns of slots an inventory will have
* Stack Size Multiplier (float)
> Multiplies an item stack size. Setting this to 0 will only allow 1 item in any given slot.
* Add To Inventories (bool)
> Whether or not an inventory is accessible by players
* Inventory Name (String)
> The name that is displayed at the top of an inventory
* Display Override (String)
> A filepath for a custom inventory UI (must be placed inside of Scenes/Displays/)
* Show Player Inventory (bool)
> Whether or not the player's inventory should be visible in the building's UI
* Can Rename (bool)
> Whether or not a building is renamable

### Things You (probably) Shouldn't Change
* Force Filters (Array)
> An array for only Movers that handles filtering
* Inventory Data (Array)
> Stores item dictionaries. Should always be modified with code and never from the inspector
* Slot Filters (Array)
> Filter a slot to a specific item, or an Array of items (uses item IDs)
* Slot Amounts (Array)
> Display a preview number on a slot for how many items are expected (typically done automatically)
* Can Insert (Array)
> A list of bools for which slots can be inserted into
* Can Take (Array)
> A list of bools for which slots can be taken from
* Initial Resize (bool)
> Whether or not an inventory should call an initial resize (only for dynamic inventories like a crafter)
* Fill Can Take Insert (bool)
> Whether or not to fill Can Insert and Can Take with false at the beginning


