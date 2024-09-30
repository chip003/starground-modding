extends Rock

## This script shows an example of how to add data to a resource before destruction

func _ready():
	super._ready()
	if multiplayer.is_server():
		dropData.push_back(Global.create_item_dict("starground:iron_ore", 2))
