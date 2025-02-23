extends Resource

func build():
	for i in itemsTable:
		itemsTable.get(i).merge(itemsDefault)

var itemsDefault = {
	"Amount": 1,
	"Held": false,
	"StackSize": 99,
	"ConsumptionCooldown": 15.0,
	"Value": 1.0,
}

## TODO: add on-use script

var itemsTable = {
	#region EGGS
	"starground:macrobear_egg": {
		"Name": "Macrobear Egg",
		"Sprite": load("res://Sprites/Items/Eggs/macrobear_egg.png"),
		"Description": "KEY_DESCRIPTION_EGG",
		"SpawnScene": "res://Scenes/macrobear.tscn",
	},
	
	"starground:sodstar_egg": {
		"Name": "Sodstar Egg",
		"Sprite": load("res://Sprites/Items/Eggs/sodstar_egg.png"),
		"Description": "KEY_DESCRIPTION_EGG",
		"SpawnScene": "res://Scenes/sodstar.tscn",
	},
	#endregion
	
	#region MISC
	"starground:nai": {
		"Name": "NAI",
		"Sprite": load("res://Sprites/Items/nai.png"),
		"Description": "KEY_DESCRIPTION_NAI"
	},
	
	"starground:mining_laser_power_+20%": {
		"Name": "Mining Laser Power +20%",
		"Sprite": load("res://Sprites/mining_laser_power_icon.png"),
	},
	
	"starground:collector_efficiency_+10%": {
		"Name": "Collector Efficiency +10%",
		"Sprite": load("res://Sprites/icon_collector_efficiency.png"),
	},
	
	"starground:thumper_speed_+10%": {
		"Name": "Thumper Speed +10%",
		"Sprite": load("res://Sprites/icon_thumper_speed.png"),
	},
	
	"starground:mover_speed_x2": {
		"Name": "Mover Speed x2",
		"Sprite": load("res://Sprites/icon_mover_speed.png"),
	},
	
	"starground:tool_shovel": {
		"Name": "Shovel",
		"Sprite": load("res://Sprites/shovel.png"),
	},
	
	"starground:heart": {
		"Name": "Heart",
		"Sprite": load("res://Sprites/Items/heart.png"),
		"Heart": true
	},
	
	"starground:dreadcap_trophy": {
		"Name": "Dreadcap Trophy",
		"Sprite": load("res://Sprites/Items/dreadcap_trophy.png"),
	},
	
	"starground:spore_trophy": {
		"Name": "Spore Trophy",
		"Sprite": load("res://Sprites/Items/spore_trophy.png"),
	},
	
	"starground:coin": {
		"Name": "Coin",
		"Sprite": load("res://Sprites/Items/coin.png"),
		"StackSize": 198
	},
	#endregion
	
	#region FISH
	"starground:trout": {
		"Name": "Trout",
		"Sprite": load("res://Sprites/Items/Fish/trout.png"),
		"FishingDifficulty": 1.5,
		"AverageSize": 20.0
	},
	
	"starground:squimp": {
		"Name": "Squimp",
		"Sprite": load("res://Sprites/Items/Fish/squimp.png"),
		"FishingDifficulty": 1.5,
		"AverageSize": 12.0
	},
	
	"starground:salmon": {
		"Name": "Salmon",
		"Sprite": load("res://Sprites/Items/Fish/salmon.png"),
		"FishingDifficulty": 1.5,
		"AverageSize": 22.0
	},
	
	"starground:clownfish": {
		"Name": "Clownfish",
		"Sprite": load("res://Sprites/Items/Fish/clownfish.png"),
		"FishingDifficulty": 1.0,
		"AverageSize": 4.0
	},
	
	"starground:blue_tang": {
		"Name": "Blue Tang",
		"Sprite": load("res://Sprites/Items/Fish/blue_tang.png"),
		"FishingDifficulty": 1.0,
		"AverageSize": 5.0
	},
	
	"starground:octopus": {
		"Name": "Octopus",
		"Sprite": load("res://Sprites/Items/Fish/octopus.png"),
		"FishingDifficulty": 2.0,
		"AverageSize": 40.0
	},
	
	"starground:pufferfish": {
		"Name": "Pufferfish",
		"Sprite": load("res://Sprites/Items/Fish/puffer_fish.png"),
		"FishingDifficulty": 1.0,
		"AverageSize": 12.0
	},
	
	"starground:eel": {
		"Name": "Eel",
		"Sprite": load("res://Sprites/Items/Fish/eel.png"),
		"FishingDifficulty": 1.5,
		"AverageSize": 24.0
	},
	
	"starground:sunfish": {
		"Name": "Sunfish",
		"Sprite": load("res://Sprites/Items/Fish/sunfish.png"),
		"FishingDifficulty": 2.0,
		"AverageSize": 71.0
	},
	
	"starground:goblin_shark": {
		"Name": "Goblin Shark",
		"Sprite": load("res://Sprites/Items/Fish/goblin_shark.png"),
		"FishingDifficulty": 2.0,
		"AverageSize": 96.0
	},
	
	"starground:bootfish": {
		"Name": "Bootfish",
		"Sprite": load("res://Sprites/Items/Fish/bootfish.png"),
		"FishingDifficulty": 3.0,
		"AverageSize": 12.0
	},
	#endregion
	
	#region POTIONS
	"starground:strength_potion": {
		"Name": "Strength Potion",
		"Sprite": load("res://Sprites/Items/Potions/strength_potion.png"),
		"Effects": [
			{
				"ID": "starground:effect_strength",
				"Length": 30.0,
			}
		]
	},
	
	"starground:regeneration_potion": {
		"Name": "Regeneration Potion",
		"Sprite": load("res://Sprites/Items/Potions/regeneration_potion.png"),
		"Effects": [
			{
				"ID": "starground:effect_regeneration",
				"Length": 10.0,
			}
		]
	},
	
	"starground:speed_potion": {
		"Name": "Speed Potion",
		"Sprite": load("res://Sprites/Items/Potions/speed_potion.png"),
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 30.0,
			}
		]
	},
	
	"starground:vitamins": {
		"Name": "Vitamins",
		"Sprite": load("res://Sprites/Items/Potions/vitamins.png"),
		"Effects": [
			{
				"ID": "starground:effect_embiggening",
				"Length": 30.0,
			}
		]
	},
	#endregion
	
	#region ARTIFACTS
	"starground:lead_boots": {
		"Name": "Lead Boots",
		"Sprite": load("res://Sprites/Items/Artifacts/lead_boots.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_LEAD_BOOTS"
	},
	"starground:magnet": {
		"Name": "Magnet",
		"Sprite": load("res://Sprites/Items/Artifacts/magnet.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_MAGNET"
	},
	"starground:preserved_clover": {
		"Name": "Preserved Clover",
		"Sprite": load("res://Sprites/Items/Artifacts/preserved_clover.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_PRESERVED_CLOVER"
	},
	"starground:chainmail_glove": {
		"Name": "Chainmail Glove",
		"Sprite": load("res://Sprites/Items/Artifacts/chainmail_glove.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_CHAINMAIL_GLOVE"
	},
	"starground:grabber": {
		"Name": "Grabber",
		"Sprite": load("res://Sprites/Items/Artifacts/grabber.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_GRABBER"
	},
	"starground:night_vision_goggles": {
		"Name": "Night Vision Goggles",
		"Sprite": load("res://Sprites/Items/Artifacts/night_vision_goggles.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_NIGHT_VISION_GOGGLES"
	},
	"starground:carrot": {
		"Name": "Carrot",
		"Sprite": load("res://Sprites/Items/Artifacts/carrot.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_CARROT"
	},
	"starground:advanced_reel": {
		"Name": "Advanced Reel",
		"Sprite": load("res://Sprites/Items/Artifacts/advanced_reel.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_REEL"
	},
	"starground:ultimate_reel": {
		"Name": "Ultimate Reel",
		"Sprite": load("res://Sprites/Items/Artifacts/ultimate_reel.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_REEL"
	},
	"starground:braided_fishing_line": {
		"Name": "Braided Fishing Line",
		"Sprite": load("res://Sprites/Items/Artifacts/braided_fishing_line.png"),
		"StackSize": 1,
		"Artifact": true,
		"Description": "KEY_DESCRIPTION_BRAIDED_FISHING_LINE"
	},
	#endregion
	
	#region RAW RESOURCES
	"starground:water": {
		"Name": "Water",
		"Sprite": load("res://Sprites/Items/water.png"),
	},
	
	"starground:sodstar_arm": {
		"Name": "Sodstar Arm",
		"Sprite": load("res://Sprites/Items/sodstar_arm.png"),
		"Value": 1.0/6.0,
	},
	
	"starground:land_tile": {
		"Name": "Land Tile",
		"Sprite": load("res://Sprites/Items/land_tile.png"),
		"Description": "KEY_DESCRIPTION_LAND_TILE",
		"StackSize": 999,
	},
	
	"starground:copper_ingot": {
		"Name": "Copper Ingot",
		"Sprite": load("res://Sprites/Items/copper_ingot.png"),
		"Value": 1.0/4.0,
	},

	"starground:copper_ore": {
		"Name": "Copper Ore",
		"Sprite": load("res://Sprites/Items/copper_ore.png"),
	},
	
	"starground:iron_ore": {
		"Name": "Iron Ore",
		"Sprite": load("res://Sprites/Items/iron_ore.png"),
	},
	
	"starground:mineral_water": {
		"Name": "Mineral Water",
		"Sprite": load("res://Sprites/Items/mineral_water.png"),
	},
	
	"starground:gemstone": {
		"Name": "Gemstone",
		"Sprite": load("res://Sprites/Items/gemstone.png"),
	},
	
	"starground:depleted_uranium": {
		"Name": "Depleted Uranium",
		"Sprite": load("res://Sprites/Items/depleted_uranium.png"),
	},
	
	"starground:uranium_ore": {
		"Name": "Uranium Ore",
		"Sprite": load("res://Sprites/Items/uranium_ore.png"),
	},
	
	"starground:cobalt_ore": {
		"Name": "Cobalt Ore",
		"Sprite": load("res://Sprites/Items/cobalt_ore.png"),
	},
	
	"starground:cobalt_dust": {
		"Name": "Cobalt Dust",
		"Sprite": load("res://Sprites/Items/cobalt_dust.png"),
	},
	
		"starground:cobalt_ingot": {
		"Name": "Cobalt Ingot",
		"Sprite": load("res://Sprites/Items/cobalt_ingot.png"),
	},
	
	"starground:uranium_dust": {
		"Name": "Uranium Dust",
		"Sprite": load("res://Sprites/Items/uranium_dust.png"),
	},
	
	"starground:uranium_pellet": {
		"Name": "Uranium Pellet",
		"Sprite": load("res://Sprites/Items/uranium_pellet.png"),
	},
	
	"starground:slag": {
		"Name": "Slag",
		"Sprite": load("res://Sprites/Items/slag.png"),
	},
	
	"starground:coal": {
		"Name": "Coal",
		"Sprite": load("res://Sprites/Items/coal.png"),
		"Fuel": 12.0,
		"Value": 1.0/4.0,
	},
	
	"starground:wood": {
		"Name": "Wood",
		"Sprite": load("res://Sprites/Items/wood.png"),
		"Fuel": 6.0,
		"Value": 1.0/6.0,
	},
	
	"starground:stone": {
		"Name": "Stone",
		"Sprite": load("res://Sprites/Items/stone.png"),
		"Damage": 0.5,
		"Cooldown": 1,
		"Knockback": 2,
		"Value": 1.0/8.0,
	},
	
	"starground:oil": {
		"Name": "Oil",
		"Sprite": load("res://Sprites/Items/oil.png"),
	},
	
	"starground:plastic": {
		"Name": "Plastic",
		"Sprite": load("res://Sprites/Items/plastic.png"),
	},
	
	#endregion
	
	#region WEAPON COMPONENTS
	"starground:tesla_core": {
		"Name": "Tesla Core",
		"Sprite": load("res://Sprites/Items/tesla_core.png"),
		"Cooldown": 5,
		"Damage": 4,
		"Reach": 6,
		"AttackScript": "res://Resources/Weapons/tesla_core.gd",
		"SpecialWeapon": true,
		"Exclusive": true,
		"Description": "KEY_DESCRIPTION_TESLA_CORE",
	},
	
	"starground:spore_scepter": {
		"Name": "Spore Scepter",
		"Sprite": load("res://Sprites/Items/spore_scepter.png"),
		"Cooldown": 8,
		"Damage": 1,
		"Reach": 3,
		"AttackScript": "res://Resources/Weapons/spore_scepter.gd",
		"SpecialWeapon": true,
		"Exclusive": true,
		"Description": "KEY_DESCRIPTION_SPORE_SCEPTER",
	},

	"starground:sword_handguard": {
		"Name": "Sword Handguard",
		"Sprite": load("res://Sprites/Items/handguard_sword.png"),
		"Cooldown": -0.15,
	},
	
	"starground:sword_handle": {
		"Name": "Sword Handle",
		"Sprite": load("res://Sprites/Items/handle_sword.png"),
		"Cooldown": 0.1,
		"Reach": 0.3
	},
	
	"starground:sword_blade": {
		"Name": "Sword Blade",
		"Sprite": load("res://Sprites/Items/blade_sword.png"),
		"Damage": 4,
		"Cooldown": 1.25,
		"Knockback": 3,
		"SelfDamage": true,
		"DamageType": ModAPI.DAMAGE.SHARP,
	},
	
	"starground:automaton_arm": {
		"Name": "Automaton Arm",
		"Sprite": load("res://Sprites/Items/automaton_arm.png"),
		"Reach": 1,
		"Cooldown": 0,
	},
	
	"starground:rubber_mallet": {
		"Name": "Rubber Mallet",
		"Sprite": load("res://Sprites/Items/rubber_mallet.png"),
		"Damage": 3,
		"Cooldown": 1,
		"Knockback": 5,
		"DamageType": ModAPI.DAMAGE.BLUNT,
	},
	
	"starground:pickaxe": {
		"Name": "Pickaxe",
		"Sprite": load("res://Sprites/Items/pickaxe.png"),
		"Damage": 2,
		"Cooldown": 0.5,
		"Knockback": 3,
		"DamageType": ModAPI.DAMAGE.BLUNT,
		"SelfDamage": false
	},
	
	"starground:dragonslayer": {
		"Name": "Dragonslayer",
		"Sprite": load("res://Sprites/Items/dragonslayer.png"),
		"Damage": 10,
		"Cooldown": 1.5,
		"Knockback": 3,
		"SelfDamage": true,
		"DamageType": ModAPI.DAMAGE.SHARP,
	},
	
	"starground:dagger_blade": {
		"Name": "Dagger Blade",
		"Sprite": load("res://Sprites/Items/blade_dagger.png"),
		"Damage": 2,
		"Cooldown": 0.3,
		"SelfDamage": true,
		"Knockback": 1,
		"DamageType": ModAPI.DAMAGE.SHARP,
	},
	
	"starground:long_handle": {
		"Name": "Long Handle",
		"Sprite": load("res://Sprites/Items/handle_long.png"),
		"Cooldown": 0.2,
		"Reach": 1
	},
	
	"starground:primitive_hammer": {
		"Name": "Primitive Hammer",
		"Sprite": load("res://Sprites/Items/primitive_hammer.png"),
		"Damage": 1.5,
		"DamageType": ModAPI.DAMAGE.BLUNT,
		"Cooldown": 0.5,
		"Knockback": 2
	},
	
	"starground:primitive_handle": {
		"Name": "Primitive Handle",
		"Sprite": load("res://Sprites/Items/primitive_handle.png"),
		"Cooldown": 0.2,
		"Reach": 0.75
	},
	
	"starground:shroomaxe": {
		"Name": "Shroomaxe",
		"Sprite": load("res://Sprites/Items/blade_shroomaxe.png"),
		"Damage": 10,
		"Cooldown": 2,
		"Knockback": 5,
		"DamageType": ModAPI.DAMAGE.SHARP,
		"SelfDamage": true
	},
	
	"starground:fungdle": {
		"Name": "Fungdle",
		"Sprite": load("res://Sprites/Items/handle_fungdle.png"),
		"Cooldown": 0.1,
		"Reach": 1.1
	},
	
	"starground:shrommel": {
		"Name": "Shrommel",
		"Sprite": load("res://Sprites/Items/shrommel.png"),
		"Cooldown": -0.2,
	},
	#endregion
	
	#region PRODUCTS
	"starground:copper_wire": {
		"Name": "Copper Wire",
		"Sprite": load("res://Sprites/Items/copper_wire.png"),
	},
	
	"starground:gear": {
		"Name": "Gear",
		"Sprite": load("res://Sprites/Items/gear.png"),
	},
	
	"starground:biofuel": {
		"Name": "Biofuel",
		"Sprite": load("res://Sprites/Items/biofuel.png"),
		"Fuel": 48.0
	},

	"starground:iron_ingot": {
		"Name": "Iron Ingot",
		"Sprite": load("res://Sprites/Items/iron_ingot.png"),
		"Value": 1.0/4.0,
	},
	
	"starground:processor": {
		"Name": "Processor",
		"Sprite": load("res://Sprites/Items/processor.png"),
	},
	
	"starground:stone_brick": {
		"Name": "Stone Brick",
		"Sprite": load("res://Sprites/Items/stone_brick.png"),
	},
	
	"starground:rotor": {
		"Name": "Rotor",
		"Sprite": load("res://Sprites/Items/rotor.png"),
	},
	
	"starground:steel": {
		"Name": "Steel",
		"Sprite": load("res://Sprites/Items/steel.png"),
	},
	
	"starground:steam": {
		"Name": "Steam",
		"Sprite": load("res://Sprites/Items/steam.png"),
	},
	
	"starground:nuclear_waste": {
		"Name": "Nuclear Waste",
		"Sprite": load("res://Sprites/Items/nuclear_waste.png"),
	},
	
	"starground:fuel_cell": {
		"Name": "Fuel Cell",
		"Sprite": load("res://Sprites/Items/fuel_cell.png"),
		"Fuel": 96.0
	},
	#endregion

	#region CONSUMABLES
	"starground:bomb": {
		"Name": "Bomb",
		"Sprite": load("res://Sprites/Items/bomb.png"),
	},
	
	"starground:nuclear_bomb": {
		"Name": "Nuclear Bomb",
		"Sprite": load("res://Sprites/Items/nuclear_bomb.png"),
	},
	
	"starground:cheese": {
		"Name": "Cheese",
		"Sprite": load("res://Sprites/Items/cheese.png"),
		"Heal": 1,
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 1.0,
			}
		]
	},
	"starground:apple_pie": {
		"Name": "Apple Pie",
		"Sprite": load("res://Sprites/Items/apple_pie.png"),
		"Heal": 2,
	},
	"starground:apple": {
		"Name": "Apple",
		"Sprite": load("res://Sprites/Items/apple.png"),
		"Heal": 1,
		"Farmable": true,
		"Value": 1.0/10.0,
	},
	"starground:moonshroom_spore": {
		"Name": "Moonshroom Spore",
		"Sprite": load("res://Sprites/Items/moonshroom_spore.png"),
		"Farmable": true,
	},
	"starground:pizza": {
		"Name": "Pizza",
		"Sprite": load("res://Sprites/Items/pizza.png"),
		"Heal": 3,
		"Effects": [
			{
				"ID": "starground:effect_endurance",
				"Length": 10.0,
			}
		]
	},
	"starground:meat_roast": {
		"Name": "Meat Roast",
		"Sprite": load("res://Sprites/Items/meat_roast.png"),
		"Heal": 2,
		"Effects": [
			{
				"ID": "starground:effect_endurance",
				"Length": 20.0,
			}
		]
	},
	"starground:moongrass": {
		"Name": "Moongrass",
		"Sprite": load("res://Sprites/Items/moongrass.png"),
		"Farmable": true
	},
	"starground:rubygrain": {
		"Name": "Rubygrain",
		"Sprite": load("res://Sprites/Items/rubygrain.png"),
		"Value": 1.0/32.0,
		"Farmable": true
	},
	"starground:moonflour": {
		"Name": "Moonflour",
		"Sprite": load("res://Sprites/Items/moonflour.png"),
	},
	"starground:moonshroom": {
		"Name": "Moonshroom",
		"Sprite": load("res://Sprites/Items/moonshroom.png"),
	},
	"starground:meat": {
		"Name": "Meat",
		"Sprite": load("res://Sprites/Items/meat.png"),
		"Heal": 0.5,
		"Value": 1.0/8.0,
	},
	"starground:grilled_cheese_sandwich": {
		"Name": "Grilled Cheese Sandwich",
		"Sprite": load("res://Sprites/Items/grilled_cheese_sandwich.png"),
		"Heal": 2,
	},
	"starground:moonberries": {
		"Name": "Moonberries",
		"Sprite": load("res://Sprites/Items/moonberries.png"),
		"Heal": 0.5,
		"Farmable": true
	},
	"starground:pumpkin": {
		"Name": "Pumpkin",
		"Sprite": load("res://Sprites/Items/pumpkin.png"),
		"Farmable": true
	},
	"starground:sugar": {
		"Name": "Sugar",
		"Sprite": load("res://Sprites/Items/sugar.png"),
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 2.0,
			}
		]
	},
	"starground:donut": {
		"Name": "Donut",
		"Sprite": load("res://Sprites/Items/donut.png"),
		"Heal": 1.5,
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 15.0,
			}
		]
	},
	"starground:pumpkin_pie": {
		"Name": "Pumpkin Pie",
		"Sprite": load("res://Sprites/Items/pumpkin_pie.png"),
		"Heal": 2.0,
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 5.0,
			}
		]
	},
	"starground:candy_cane": {
		"Name": "Candy Cane",
		"Sprite": load("res://Sprites/Items/candy_cane.png"),
		"Heal": 0.5,
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 5.0,
			}
		]
	},
	"starground:cookie": {
		"Name": "Cookie",
		"Sprite": load("res://Sprites/Items/cookie.png"),
		"Heal": 0.5,
		"Effects": [
			{
				"ID": "starground:effect_speed",
				"Length": 5.0,
			}
		]
	},
	#endregion
	
	#region LOGS
	"starground:log_1": {
		"Name": "Log #1",
		"Sprite": load("res://Sprites/Items/data_key.png"),
		#"ComputerImage": load("res://Sprites/tree_of_wisdom.png"),
		"ComputerText": Global.load_text_from_file("res://Resources/Logs/log_1.txt")
	},
	#endregion
}
