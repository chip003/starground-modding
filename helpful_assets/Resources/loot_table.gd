extends Resource

var lootTable = {
	#weight, resourceScene
	"starground:loot_resource_nodes": [
		[10, load("res://Scenes/tree.tscn")],
		[8, load("res://Scenes/rock.tscn")],
		[8, load("res://Scenes/iron_rock.tscn")],
		[8, load("res://Scenes/copper_rock.tscn")],
		[4, load("res://Scenes/coal_rock.tscn")],
	],
	
	"starground:loot_resource_nodes_tyria": [
		[8, load("res://Scenes/basalt_rock.tscn")],
		[4, load("res://Scenes/basalt_uranium.tscn")],
		[4, load("res://Scenes/basalt_cobalt.tscn")],
	],
	
	"starground:loot_tyria_tiles": [
		[10, Vector2(0,0)],
		[10, Vector2(1,0)],
		[10, Vector2(2,0)],
		[0.5, Vector2(3,0)],
		
		[10, Vector2(0,1)],
		[10, Vector2(1,1)],
		[10, Vector2(2,1)],
		[1, Vector2(3,1)],
		
		[10, Vector2(0,2)],
		[0.5, Vector2(1,2)],
		[0.5, Vector2(2,2)],
	],
	
	"starground:loot_tyria_plant_tiles": [
		[10, Vector2(0,4)],
		[10, Vector2(1,4)],
		[10, Vector2(2,4)],
		[10, Vector2(3,4)],
	],
	
	#weight, itemID, quantityRange
	"starground:loot_fountain": [
		[100, "Nothing", Vector2(0,0)],
		[10, "starground:coin", Vector2(1,4)],
		[5, "starground:apple", Vector2(1,2)],
		[5, "starground:cheese", Vector2(1,2)],
		[3, "starground:bomb", Vector2(1,3)],
		[0.5, "starground:nuclear_bomb", Vector2(1,1)],
		[0.1, "starground:dragonslayer", Vector2(1,1)],
	],
	
	#weight, itemID, quantityRange
	"starground:loot_chance_shrine": [
		[20, "starground:coin", Vector2(5,15)],
		[10, "starground:cheese", Vector2(1,2)],
		
		[2, "starground:sword_blade", Vector2(1,1)],
		[2, "starground:dagger_blade", Vector2(1,1)],
		[2, "starground:sword_handguard", Vector2(1,1)],
		[2, "starground:long_handle", Vector2(1,1)],
		
		[1, "starground:magnet", Vector2(1,1)],
		[1, "starground:lead_boots", Vector2(1,1)],
		[1, "starground:preserved_clover", Vector2(1,1)],
		[1, "starground:chainmail_glove", Vector2(1,1)],
		[1, "starground:grabber", Vector2(1,1)],
		[1, "starground:night_vision_goggles", Vector2(1,1)],
	],
	
	#weight, itemID
	"starground:loot_pedestal": [
		[5, "starground:heart"],
		[2, "starground:bomb"],
	],
	
	#weight, itemID, quantityRange
	"starground:loot_enemy_rare": [
		[1, "starground:coin", Vector2(10,20)],
		[1, "starground:magnet", Vector2(1,1)],
		[1, "starground:preserved_clover", Vector2(1,1)],
		[1, "starground:lead_boots", Vector2(1,1)],
		[1, "starground:chainmail_glove", Vector2(1,1)],
		[1, "starground:grabber", Vector2(1,1)],
		[1, "starground:night_vision_goggles", Vector2(1,1)],
	],
	
	#weight, itemID, quantityRange
	"starground:loot_chest_1_1": [
		[1, "starground:wood", Vector2i(1,10)],
		[1, "starground:stone", Vector2i(1,10)],
		[1, "starground:iron_ingot", Vector2i(1,5)],
		[1, "starground:sword_handle", Vector2i(1,1)],
		[1, "starground:sword_handguard", Vector2i(1,1)],
		[1, "starground:sword_blade", Vector2i(1,1)],
		[1, "starground:long_handle", Vector2i(1,1)],
		[1, "starground:dagger_blade", Vector2i(1,1)],
	],
	
	"starground:loot_chest_1_2": [
		[4, "starground:processor", Vector2i(1,10)],
		[8, "starground:iron_ingot", Vector2i(1,5)],
		[8, "starground:sword_handle", Vector2i(1,1)],
		[8, "starground:sword_handguard", Vector2i(1,1)],
		[8, "starground:sword_blade", Vector2i(1,1)],
		[8, "starground:long_handle", Vector2i(1,1)],
		[8, "starground:dagger_blade", Vector2i(1,1)],
		[1, "starground:tesla_core", Vector2i(1,1)],
	],
	
	"starground:loot_dreadcap": [
		[1, "starground:shroomaxe"],
		[1, "starground:fungdle"],
		[1, "starground:shrommel"],
	],
	
	"starground:loot_spore": [
		[1, "starground:shrommel"],
		[1, "starground:fungdle"],
		[1, "starground:spore_scepter"],
	],
	
	"starground:loot_fish_size": [
		[15, 0],
		[10, 1],
		[4, 2],
	],
	
	## Small Fish
	"starground:loot_0_fish": [
		[10, "starground:clownfish"],
		[10, "starground:blue_tang"],
		[10, "starground:pufferfish"],
		[2, "starground:copper_wire"],
		[2, "starground:processor"],
		[1, "starground:vitamins"],
		[0.5, "starground:bootfish"]
	],
	
	## Medium Fish
	"starground:loot_1_fish": [
		[10, "starground:trout"],
		[10, "starground:salmon"],
		[10, "starground:eel"],
		[10, "starground:squimp"],
		[2, "starground:wood"],
		[2, "starground:steel"],
	],
	
	## Large Fish
	"starground:loot_2_fish": [
		[50, "starground:octopus"],
		[50, "starground:goblin_shark"],
		[50, "starground:sunfish"],
		[1, "starground:nuclear_bomb"],
	],
	
	"starground:loot_enemies_1_1": [
		[5, load("res://Scenes/Enemies/moon_shroom.tscn")],
		[5, load("res://Scenes/Enemies/ancient_automaton.tscn")],
		[2, load("res://Scenes/Enemies/slime.tscn")]
	],
	
	"starground:loot_enemies_1_2": [
		[5, load("res://Scenes/Enemies/diadematus.tscn")],
		[5, load("res://Scenes/Enemies/the_face.tscn")],
	],
	
	"starground:loot_decoration_1_1": [
		[10, "Crate"],
		[5, "BigCrate"],
		[10, "Plant1"],
		[10, "Plant2"],
		[10, "Pots"],
		[2, "Poison"],
		[10, "Barrel"],
		[20, "Moongrass"],
	],
	
	"starground:loot_decoration_1_2": [
		[10, "Poison"],
		[20, "Lumen Orchid"],
		[20, "Moonshrub"],
		[5, "BigCrate"],
		[2, "Crate"],
		[5, "TestTubes"],
	],
	
	"starground:loot_trading_terminal": [
		[10, "starground:stone"],
		[10, "starground:wood"],
		[10, "starground:iron_ingot"],
		[10, "starground:copper_ingot"],
		[10, "starground:coal"],
		[10, "starground:apple"],
		[10, "starground:sodstar_arm"],
		[10, "starground:meat"],
	]
}
