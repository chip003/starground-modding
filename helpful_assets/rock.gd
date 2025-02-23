extends Rock

func _ready():
	super()
	if isServer:
		dropData.push_back(ModAPI.create_item_dict("starground:stone", 2))
	

func _add_before_drop():
	if hitByPlayer:
		if randi_range(1,200) == 1:
			playerDrops.push_back(ModAPI.create_item_dict("starground:pickaxe", 1))
