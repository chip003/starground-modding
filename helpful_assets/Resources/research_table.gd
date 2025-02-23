extends Resource

enum RESEARCH_TYPES {INFINITE, SINGLE, TIERED}

func build():
	for i in researchTable:
		researchTable.get(i).merge(researchDefault)

var researchDefault = {
	"Requires": [],
	"Type": RESEARCH_TYPES.SINGLE,
}

var researchTable = {
	"starground:research_better_automation": {
		"Name": "Better Automation",
		"Input": [
			{
				"ID": "starground:gear",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_long_range_mover",
			"starground:building_splitter",
			"starground:building_underground_conveyor"
		]
	},
	
	"starground:research_mover_speed": {
		"Requires": ["starground:research_oil_processing"],
		"Name": "Mover Speed",
		"Type": RESEARCH_TYPES.TIERED,
		"EffectIncrement": 1.0,
		"Input": [
			[ #LEVEL 1
				{
					"ID": "starground:rotor",
					"Amount": 20, 
				},
				{
					"ID": "starground:processor",
					"Amount": 10,
				}
			],
			#[ #LEVEL 2
				#{
					#"Name": "Gear",
					#"Amount": 1,
				#},
			#],
		],
		"Unlocks": [
			"starground:mover_speed_x2"
		]
	},
	
	"starground:research_decorations": {
		"Name": "Decorations",
		"Input": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 10,
			},
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:stone",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_lamp",
			"starground:building_stone_wall",
			"starground:building_speaker",
			"starground:building_dreadcap_monument",
			"starground:building_spore_monument",
			"starground:building_godot_plush",
			"starground:building_plant_1",
			"starground:building_plant_2",
			"starground:building_plant_3",
		]
	},
	
	"starground:research_better_storage": {
		"Name": "Better Storage",
		"Input": [
			{
				"ID": "starground:stone_brick",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_big_chest",
			"starground:building_storage_hub",
		]
	},
	
	"starground:research_faster_logistics": {
		"Name": "Faster Logistics",
		"Input": [
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
			{
				"ID": "starground:gear",
				"Amount": 10,
			},
			{
				"ID": "starground:processor",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_conveyor_v2",
			"starground:building_splitter_v2",
			"starground:building_underground_conveyor_v2",
		]
	},
	
	"starground:research_alloying": {
		"Name": "Alloying",
		"Input": [
			{
				"ID": "starground:iron_ingot",
				"Amount": 20,
			},
			{
				"ID": "starground:coal",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_foundry",
			"starground:steel",
			"starground:building_vault",
			"starground:sword_blade",
		]
	},
	
	"starground:research_clean_energy": {
		"Name": "Clean Energy",
		"Requires": ["starground:research_alloying"],
		"Input": [
			{
				"ID": "starground:steel",
				"Amount": 30,
			},
		],
		"Unlocks": [
			"starground:building_solar_panel",
			"starground:building_big_battery",
		]
	},
	
	"starground:research_oil_processing": {
		"Name": "Oil Processing",
		"Requires": ["starground:research_alloying"],
		"Input": [
			{
				"ID": "starground:steel",
				"Amount": 20,
			},
			{
				"ID": "starground:copper_ingot",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_refiner",
			"starground:building_oil_rig",
			"starground:rotor",
			"starground:plastic",
			"starground:oil",
			"starground:fuel_cell"
		]
	},
	
	"starground:research_toys": {
		"Name": "Toys",
		"Requires": ["starground:research_oil_processing"],
		"Input": [
			{
				"ID": "starground:plastic",
				"Amount": 10,
			},
			{
				"ID": "starground:wood",
				"Amount": 10,
			},
			{
				"ID": "starground:water",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_skateboard",
			"starground:building_christmas_tree",
			"starground:building_rubber_ducky",
			"starground:building_beach_ball",
			"starground:building_present",
			"starground:building_snowman",
		]
	},
	
	"starground:research_electric_furnaces": {
		"Name": "Electric Furnaces",
		"Requires": ["starground:research_oil_processing"],
		"Input": [
			{
				"ID": "starground:plastic",
				"Amount": 10,
			},
			{
				"ID": "starground:processor",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_electric_furnace",
		]
	},
	
	"starground:research_advanced_collection": {
		"Name": "Advanced Collection",
		"Requires": ["starground:research_oil_processing"],
		"Input": [
			{
				"ID": "starground:plastic",
				"Amount": 20,
			},
			{
				"ID": "starground:rotor",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_thumper",
			"starground:building_harvester",
		]
	},
	
	"starground:research_tyria": {
		"Name": "Tyria",
		"Requires": ["starground:research_oil_processing"],
		"Input": [
			{
				"ID": "starground:plastic",
				"Amount": 10,
			},
			{
				"ID": "starground:fuel_cell",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:region_tyria",
			"starground:building_purifier",
			"starground:slag",
			
			"starground:cobalt_ore",
			"starground:cobalt_dust",
			"starground:cobalt_ingot",
			
			"starground:uranium_ore",
			"starground:uranium_dust",
			"starground:uranium_pellet",
			
			"starground:mineral_water",
		]
	},
	
	"starground:research_pressurized_buildings": {
		"Name": "Pressurized Buildings",
		"Requires": ["starground:research_tyria"],
		"Input": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 10,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_pressure_wall",
			"starground:building_pressure_airlock",
			"starground:building_pressure_storage_interface",
			"starground:building_pressure_pump",
		]
	},
	
	"starground:research_nuclear_fission": {
		"Name": "Nuclear Fission",
		"Requires": ["starground:research_tyria"],
		"Input": [
			{
				"ID": "starground:uranium_pellet",
				"Amount": 20,
			},
		],
		"Unlocks": [
			"starground:building_nuclear_reactor",
			"starground:building_nuclear_turbine",
			"starground:steam",
			"starground:nuclear_bomb",
			"starground:nuclear_waste",
		]
	},
	
	"starground:research_advanced_power_distribution": {
		"Name": "Advanced Power Distribution",
		"Requires": ["starground:research_tyria"],
		"Input": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_tesla_coil_v2",
		]
	},
	
	"starground:research_resource_processing": {
		"Name": "Resource Processing",
		"Requires": ["starground:research_nuclear_fission"],
		"Input": [
			{
				"ID": "starground:slag",
				"Amount": 10,
			},
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:recipe_slag_processing",
			"starground:recipe_wood_refining",
			"starground:recipe_nuclear_waste_reprocessing",
			"starground:depleted_uranium",
		]
	},
	
	"starground:research_interplanetary_logistics": {
		"Name": "Interplanetary Logistics",
		"Requires": ["starground:research_resource_processing"],
		"Input": [
			{
				"ID": "starground:depleted_uranium",
				"Amount": 20,
			},
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 20,
			},
			{
				"ID": "starground:rotor",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:building_space_elevator",
		]
	},
	
	"starground:research_terrain_manipulation": {
		"Name": "Terrain Manipulation",
		"Requires": ["starground:research_resource_processing"],
		"Input": [
			{
				"ID": "starground:stone",
				"Amount": 40,
			},
			{
				"ID": "starground:depleted_uranium",
				"Amount": 10,
			},
		],
		"Unlocks": [
			"starground:tool_shovel",
			"starground:land_tile",
			"starground:building_land_tile",
		]
	},
	
	"starground:research_mining_laser_power": {
		"Requires": ["starground:research_oil_processing"],
		"Name": "Mining Laser Power",
		"Type": RESEARCH_TYPES.INFINITE,
		"CostMultiplier": 1.5,
		"EffectIncrement": 0.2,
		"Input": [
			{
				"ID": "starground:copper_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:rotor",
				"Amount": 5,
			},
		],
		"Unlocks": [
			"starground:mining_laser_power_+20%",
		]
	},
	
	"starground:research_collector_efficiency": {
		"Requires": ["starground:research_oil_processing"],
		"Name": "Collector Efficiency",
		"Type": RESEARCH_TYPES.INFINITE,
		"CostMultiplier": 1.5,
		"EffectIncrement": 0.1,
		"Input": [
			{
				"ID": "starground:plastic",
				"Amount": 5,
			},
			{
				"ID": "starground:processor",
				"Amount": 5,
			},
		],
		"Unlocks": [
			"starground:collector_efficiency_+10%",
		]
	},
	
	"starground:research_thumper_speed": {
		"Requires": ["starground:research_tyria"],
		"Name": "Thumper Speed",
		"Type": RESEARCH_TYPES.INFINITE,
		"CostMultiplier": 1.5,
		"EffectIncrement": 0.1,
		"Input": [
			{
				"ID": "starground:cobalt_ingot",
				"Amount": 5,
			},
			{
				"ID": "starground:stone_brick",
				"Amount": 5,
			},
		],
		"Unlocks": [
			"starground:thumper_speed_+10%",
		]
	}
}
