extends Resource

var unlocksTable = {
	"starground:unlock_fishing_license": {
		"Name": "Fishing License",
		"Sprite": load("res://Sprites/fishing_rod.png"),
		"Description": "KEY_DESCRIPTION_FISHING_LICENSE",
		"Unlocks": [
			"starground:tool_fishing_rod",
		]
	},
	
	"starground:unlock_animals": {
		"Name": "Animal License",
		"Sprite": load("res://Sprites/fishing_rod.png"),
		"Description": "KEY_DESCRIPTION_ANIMAL_LICENSE",
		"Unlocks": [
			"starground:macrobear_egg",
			"starground:sodstar_egg",
		]
	}
}
