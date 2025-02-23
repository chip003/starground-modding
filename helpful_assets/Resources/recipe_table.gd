extends Resource

var recipeTable = {
	"starground:building_nuclear_reactor": {
		"starground:steam": {
			"Input": [
				{
					"ID": "starground:water",
					"Amount": 16,
				},
				{
					"ID": "starground:uranium_pellet",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:steam",
					"Amount": 8,
				},
				{
					"ID": "starground:nuclear_waste",
					"Amount": 1,
				}
			]
		}
	},
		
	"starground:building_nuclear_turbine": {
		"starground:recipe_generate": {
			"Input": [
				{
					"ID": "starground:steam",
					"Amount": 2,
				},
			],
			"Output": [
				{
					"ID": "starground:water",
					"Amount": 1,
				}
			]
		}
	},
		
	"starground:building_purifier": {
		"starground:recipe_water_filtering": {
			"Sprite": load("res://Sprites/Items/water.png"),
			"Name": "Water Filtering",
			
			"Input": [
				{
					"ID": "starground:mineral_water",
					"Amount": 8,
				},
			],
			
			"Output": [
				{
					"ID": "starground:water",
					"Amount": 8,
				},
				
				{
					"ID": "starground:gemstone",
					"Amount": 1,
				},
			],
		},
		
		"starground:uranium_pellet": {
			"Input": [
				{
					"ID": "starground:uranium_dust",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:uranium_pellet",
					"Amount": 1,
				},
				
				{
					"ID": "starground:slag",
					"Amount": 1,
				},	
			],
		},
		
		"starground:recipe_slag_processing": {
			"Sprite": load("res://Sprites/Items/slag.png"),
			"Name": "Slag Processing",
			
			"Input": [
				{
					"ID": "starground:slag",
					"Amount": 10,
				},
			],
			
			"Output": [
				{
					"ID": "starground:iron_ingot",
					"Amount": 1,
				},
				
				{
					"ID": "starground:copper_ingot",
					"Amount": 1,
				},	
			],
		},
		
		"starground:recipe_nuclear_waste_reprocessing": {
			"Sprite": load("res://Sprites/Items/nuclear_waste.png"),
			"Name": "Nuclear Waste Reprocessing",
			
			"Input": [
				{
					"ID": "starground:nuclear_waste",
					"Amount": 4,
				},
				{
					"ID": "starground:uranium_pellet",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:uranium_pellet",
					"Amount": 2,
				},
			],
		},
		
		"starground:depleted_uranium": {
			"Input": [
				{
					"ID": "starground:nuclear_waste",
					"Amount": 4,
				},
			],
			
			"Output": [
				{
					"ID": "starground:depleted_uranium",
					"Amount": 1,
				},
			],
		},
	},
	
	
	"starground:building_crafter": {
		"starground:gear": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:iron_ingot",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:gear",
					"Amount": 1,
				}
			],
		},
		
		"starground:copper_wire": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:copper_ingot",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:copper_wire",
					"Amount": 2,
				},
			]
		},
		
		"starground:biofuel": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:wood",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:biofuel",
					"Amount": 1,
				},
			]
		},
		
		"starground:processor": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:copper_wire",
					"Amount": 2,
				},
				{
					"ID": "starground:iron_ingot",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:processor",
					"Amount": 1,
				},
			]
		},
		
		"starground:rotor": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:copper_wire",
					"Amount": 2,
				},
				{
					"ID": "starground:steel",
					"Amount": 1,
				},
				{
					"ID": "starground:gear",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:rotor",
					"Amount": 1,
				},
			]
		},
		
		"starground:primitive_hammer": {
			"Category": "Weapons",
			"Input": [
				{
					"ID": "starground:stone",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:primitive_hammer",
					"Amount": 1,
				},
			]
		},
		
		"starground:primitive_handle": {
			"Category": "Weapons",
			"Input": [
				{
					"ID": "starground:wood",
					"Amount": 3,
				},
			],
			
			"Output": [
				{
					"ID": "starground:primitive_handle",
					"Amount": 1,
				},
			]
		},
		
		"starground:sword_blade": {
			"Category": "Weapons",
			"Input": [
				{
					"ID": "starground:steel",
					"Amount": 10,
				},
			],
			
			"Output": [
				{
					"ID": "starground:sword_blade",
					"Amount": 1,
				},
			]
		},
		
		"starground:bomb": {
			"Category": "Weapons",
			"Input": [
				{
					"ID": "starground:iron_ingot",
					"Amount": 5,
				},
				{
					"ID": "starground:coal",
					"Amount": 5,	
				},
				{
					"ID": "starground:biofuel",
					"Amount": 5,	
				}
			],
			
			"Output": [
				{
					"ID": "starground:bomb",
					"Amount": 1,
				},
			]
		},
		
		"starground:nuclear_bomb": {
			"Category": "Weapons",
			"Input": [
				{
					"ID": "starground:steel",
					"Amount": 10,
				},
				{
					"ID": "starground:uranium_pellet",
					"Amount": 15,
				},
				{
					"ID": "starground:copper_wire",
					"Amount": 5,
				},
				{
					"ID": "starground:cobalt_ingot",
					"Amount": 5,
				}
			],
			
			"Output": [
				{
					"ID": "starground:nuclear_bomb",
					"Amount": 1,
				},
			]
		},
	},
	
	"starground:building_grinder": {
		"starground:uranium_dust": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:uranium_ore",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:uranium_dust",
					"Amount": 1,
				},
			]
		},
		
		"starground:cobalt_dust": {
			"Category": "Products",
			"Input": [
				{
					"ID": "starground:cobalt_ore",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:cobalt_dust",
					"Amount": 1,
				},
			]
		},
		
		"starground:moonflour": {
			"Category": "Food",
			"Input": [
				{
					"ID": "starground:moongrass",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:moonflour",
					"Amount": 2,
				},
			]
		},
		
		"starground:sugar": {
			"Category": "Food",
			"Input": [
				{
					"ID": "starground:moonberries",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:sugar",
					"Amount": 1,
				},
			]
		}
	},
	
	
	"starground:building_oven": {
		"starground:apple_pie": {
			"Input": [
				{
					"ID": "starground:apple",
					"Amount": 5,
				},
				{
					"ID": "starground:moonflour",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:apple_pie",
					"Amount": 1,
				},
			]
		},
		
		"starground:pumpkin_pie": {
			"Input": [
				{
					"ID": "starground:pumpkin",
					"Amount": 2,
				},
				{
					"ID": "starground:moonflour",
					"Amount": 2,
				},
				{
					"ID": "starground:sugar",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:pumpkin_pie",
					"Amount": 1,
				},
			]
		},
		
		"starground:pizza": {
			"Input": [
				{
					"ID": "starground:moonflour",
					"Amount": 3,
				},
				{
					"ID": "starground:meat",
					"Amount": 2,
				},
				{
					"ID": "starground:cheese",
					"Amount": 1,
				},
				{
					"ID": "starground:moonshroom",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:pizza",
					"Amount": 1,
				},
			]
		},
		"starground:grilled_cheese_sandwich": {
			"Input": [
				{
					"ID": "starground:moonflour",
					"Amount": 2,
				},
				{
					"ID": "starground:water",
					"Amount": 2,
				},
				{
					"ID": "starground:cheese",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:grilled_cheese_sandwich",
					"Amount": 1,
				},
			]
		},
		"starground:donut": {
			"Input": [
				{
					"ID": "starground:moonflour",
					"Amount": 1,
				},
				{
					"ID": "starground:water",
					"Amount": 1,
				},
				{
					"ID": "starground:sugar",
					"Amount": 3,
				},
			],
			
			"Output": [
				{
					"ID": "starground:donut",
					"Amount": 1,
				},
			]
		},
		
		"starground:candy_cane": {
			"Input": [
				{
					"ID": "starground:water",
					"Amount": 1,
				},
				{
					"ID": "starground:sugar",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:candy_cane",
					"Amount": 2,
				},
			]
		},
		"starground:cookie": {
			"Input": [
				{
					"ID": "starground:water",
					"Amount": 1,
				},
				{
					"ID": "starground:sugar",
					"Amount": 2,
				},
				{
					"ID": "starground:moonflour",
					"Amount": 2,
				},
			],
			
			"Output": [
				{
					"ID": "starground:cookie",
					"Amount": 4,
				},
			]
		},
		
		"starground:meat_roast": {
			"Input": [
				{
					"ID": "starground:meat",
					"Amount": 4,
				},
				{
					"ID": "starground:sugar",
					"Amount": 1,
				},
				{
					"ID": "starground:water",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:meat_roast",
					"Amount": 1,
				},
			]
		},
	},
	
	
	#furnace has input id as key rather than output
	"starground:building_furnace": {
		"starground:stone": {
			"Input": {
				"ID": "starground:stone",
				"Amount": 1,
			},
			
			"Output": {
				"ID": "starground:stone_brick",
				"Amount": 1,
			},
		},
		
		"starground:copper_ore": {
			"Input": {
				"ID": "starground:copper_ore",
				"Amount": 1,
			},
			
			"Output": {
				"ID": "starground:copper_ingot",
				"Amount": 1,
			},
		},
				
		"starground:iron_ore": {
			"Input": {
				"ID": "starground:iron_ore",
				"Amount": 1,
			},
			
			"Output": {
				"ID": "starground:iron_ingot",
				"Amount": 1,
			},
		},
	},
	
	"starground:building_foundry": {
		"starground:steel": {
			"Input": [
				{
					"ID": "starground:iron_ingot",
					"Amount": 1,
				},
				{
					"ID": "starground:coal",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:steel",
					"Amount": 1,
				},
			]
		},
		
		"starground:cobalt_ingot": {
			"Input": [
				{
					"ID": "starground:cobalt_dust",
					"Amount": 2,
				},
			],
			"Output": [
				{
					"ID": "starground:cobalt_ingot",
					"Amount": 1,
				},
				{
					"ID": "starground:slag",
					"Amount": 1,
				}
			]
		},
		
		"starground:recipe_wood_refining": {
			"Sprite": load("res://Sprites/Items/coal.png"),
			"Name": "Wood Refining",
			
			"Input": [
				{
					"ID": "starground:wood",
					"Amount": 5,
				},
			],
			"Output": [
				{
					"ID": "starground:coal",
					"Amount": 1,
				},
			]
		}
	},
	
	"starground:building_refiner": {
		"starground:fuel_cell": {
			"Input": [
				{
					"ID": "starground:oil",
					"Amount": 1,
				},
				{
					"ID": "starground:copper_ingot",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:fuel_cell",
					"Amount": 1,
				},
			]
		},
		
		"starground:plastic": {
			"Input": [
				{
					"ID": "starground:oil",
					"Amount": 1,
				},
				{
					"ID": "starground:coal",
					"Amount": 1,
				},
			],
			
			"Output": [
				{
					"ID": "starground:plastic",
					"Amount": 1,
				},
			]
		},
	},
	
	"starground:building_water_pump": {
		"starground:water": {
			"Input": [],
			"Output": [
				{
					"ID": "starground:water",
					"Amount": 1,
				},
			]
		},
		
		"starground:mineral_water": {
			"Input": [],
			"Output": [
				{
					"ID": "starground:mineral_water",
					"Amount": 1,
				},
			]
		},
	},
	
	#farm plot has input id as key rather than output
	"starground:building_farm_plot": {
		"starground:apple": {
			"PlantSprite": load("res://Sprites/tree.png"),
			"PlantOffset": Vector2(0,-14),
			"Input": [
				{
					"ID": "starground:apple",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:wood",
					"Amount": 2,
				},
				{
					"ID": "starground:apple",
					"Amount": 1,
				},
			],
		},
		"starground:moonshroom_spore": {
			"PlantSprite": load("res://Sprites/moon_shroom_deflated.png"),
			"PlantOffset": Vector2(0,-6),
			"Input": [
				{
					"ID": "starground:moonshroom_spore",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:moonshroom",
					"Amount": 1,
				},
			],
		},
		
		"starground:moongrass": {
			"PlantSprite": load("res://Sprites/moongrass_plant.png"),
			"PlantOffset": Vector2(0,-3),
			"Input": [
				{
					"ID": "starground:moongrass",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:moongrass",
					"Amount": 1,
				},
			],
		},
		
		"starground:moonberries": {
			"PlantSprite": load("res://Sprites/moonshrub.png"),
			"PlantOffset": Vector2(0,-7),
			"Input": [
				{
					"ID": "starground:moonberries",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:moonberries",
					"Amount": 1,
				},
			],
		},
		
		"starground:pumpkin": {
			"PlantSprite": load("res://Sprites/pumpkin_plant.png"),
			"PlantOffset": Vector2(0,-3),
			"Input": [
				{
					"ID": "starground:pumpkin",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:pumpkin",
					"Amount": 1,
				},
			],
		},
		
		"starground:rubygrain": {
			"PlantSprite": load("res://Sprites/rubygrain_plant.png"),
			"PlantOffset": Vector2(0,-5),
			"Input": [
				{
					"ID": "starground:rubygrain",
					"Amount": 1,
				},
			],
			"Output": [
				{
					"ID": "starground:rubygrain",
					"Amount": 1,
				},
			],
		},
	},
	
	"starground:building_brewing_station": {
		"starground:strength_potion": {
			"Input": [
				{
					"ID": "starground:pumpkin",
					"Amount": 5,
				},
				{
					"ID": "starground:iron_ingot",
					"Amount": 2,
				},
				{
					"ID": "starground:biofuel",
					"Amount": 2,
				},
				{
					"ID": "starground:water",
					"Amount": 5,
				},
			],
			"Output": [
				{
					"ID": "starground:strength_potion",
					"Amount": 1,
				},
			],
		},
		
		"starground:regeneration_potion": {
			"Input": [
				{
					"ID": "starground:sodstar_arm",
					"Amount": 2,
				},
				{
					"ID": "starground:gemstone",
					"Amount": 4,
				},
				{
					"ID": "starground:cookie",
					"Amount": 1,
				},
				{
					"ID": "starground:water",
					"Amount": 5,
				},
			],
			"Output": [
				{
					"ID": "starground:regeneration_potion",
					"Amount": 1,
				},
			],
		},
		
		"starground:speed_potion": {
			"Input": [
				{
					"ID": "starground:sugar",
					"Amount": 5,
				},
				{
					"ID": "starground:water",
					"Amount": 5,
				},
			],
			"Output": [
				{
					"ID": "starground:speed_potion",
					"Amount": 1,
				},
			],
		}
	}
}
