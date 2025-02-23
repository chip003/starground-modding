extends Resource

func build():
	for i in regionsTable:
		regionsTable.get(i).merge(regionsDefault)

var regionsDefault = {
	"Underwater": false,
	"Sprite": load("res://Sprites/icon_planet_unknown.png"),
	"SeedOffset": 0,
	"TerrainColor": Color.hex(0x75B778FF),
	"ShoreColor": Color.hex(0x34CEC5FF),
	"WaterColor": Color.hex(0x2AA4AAFF),
	"SpawnOffset": Vector2.ZERO
}

var regionsTable = {
	## Automation Zones
	"starground:region_veridian": {
		"Name": "Veridian",
		"Location": Vector2(0,0),
		"RegionType": ModAPI.REGION.AUTOMATION,
		"Tilemap": "level/Tiles/Terrain",
	},
	
	"starground:region_tyria": {
		"Name": "Tyria",
		"Sprite": load("res://Sprites/icon_planet_tyria.png"),
		"Location": Vector2(0,20000),
		"RegionType": ModAPI.REGION.AUTOMATION,
		"Tilemap": "level/TilesGem/Terrain",
		"DecorationTilemap": "level/TilesGem/Plants",
		"Underwater": true,
		"SeedOffset": 1,
		"TerrainColor": Color.hex(0xB67AB0FF),
		"ShoreColor": Color.hex(0xB67AB0FF),
		"WaterColor": Color.hex(0xB67AB0FF),
	},
	
	## Dungeon Zones
	"starground:region_enceladus": {
		"Name": "Enceladus",
		"Location": Vector2(-20000,0),
		"RegionType": ModAPI.REGION.DUNGEON,
	},
	
	## Misc Zones
	"starground:region_space_hub": {
		"Name": "Space Hub",
		"Location": Vector2(10000,0),
		"RegionType": ModAPI.REGION.SPACE,
		"Tilemap": "SpaceHub/Tiles/Terrain",
		"SpawnOffset": Vector2(0,212)
	},
}
