# Classes
Classes are a master script that other scripts can inherit from. They are typically used for a type of scene, like a building or a living entity. They differ from components in that behavior is not wrapped into a node, but integrates into it's extended scripts.

## Entity (entity.gd)
This is a parent class that extends from CharacterBody2D. Any living creature within Starground should extend from Entity. This script handles a large number of different tasks, like:

* Health and taking damage
* Applying and processing effects
* Death and creating corpses
* Playing damage taken sounds

## Breakable (breakable.gd)
Breakable is a parent class that extends from StaticBody2D. This class will handle many functions related to any static structure that can be broken and can optionally drop items. It handles logic for:

* How many hits from the mining laser is required for it to break
* Creating and updating the health progress bar
* Automatically healing after 10 seconds
* Dropping a list of items on destruction
* Creating destruction particles
* Playing a break sound
* A very performant function for vibration.

## Buildable (buildable.gd)
Buildable is a subclass of Breakable, which includes specific behaviors for structures that are marked as buildings. Any building that is added to the BuildingsTable needs to extend from Buildable. This class handles:

* Playing a drop-down animation when built
* Handling indicators (sprites that appear when a player hovers over them)
* Automatically dropping the ingredients required to build it
* Updating power warning indicators
* Allowing interaction with inventories
* And many other miscellaneous abilities
