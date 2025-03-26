class_name SaveComponent extends Node

## Which variables to save from the parent object.
@export var variables : PackedStringArray

func save_dict():
	var data = {
				   "Name": get_parent().name,
				   "Path": get_parent().scene_file_path,
				   "Position": get_parent().position,
			   }

	var inv = get_parent().get_node_or_null("inventory_component")
	if inv != null:
		data.InventoryData = inv.inventoryData
		data.FilterData = inv.forceFilters
		data.Blacklist = inv.blacklist


	var inv2 = get_parent().get_node_or_null("weapon_configuration")
	if inv2 != null:
		data.InventoryData2 = inv2.inventoryData
		data.FilterData2 = inv2.forceFilters


	for string in variables:
		var variable = get_parent().get(string)
		if variable != null:
			data[string] = variable

	return data


func load_dict(data):
	get_parent().name = data.Name
	get_parent().position = data.Position

	var inv = get_parent().get_node_or_null("inventory_component")
	if inv:
		var invData = data.get("InventoryData", [])

		if Global.foundConvertFormat < 1:
			## convert old saves to new ID format
			if invData != []:
				for i in invData:
					if i != null:
						var itemName = i.get("Name")
						if itemName:
							i.erase("Name")
							var newID = Global.convert_name(itemName)
							i.merge({"ID": newID})

		inv.inventoryData = invData

		var invForceFilters = data.get("FilterData", [null, null, null, null])

		if Global.foundConvertFormat < 1:
			## convert old saves to new ID format
			if invForceFilters != [null, null, null, null]:
				for i in range(invForceFilters.size()):
					if invForceFilters[i] != null:
						var itemName = invForceFilters[i].get("Name")
						if itemName:
							invForceFilters[i].erase("Name")
							var newID = Global.convert_name(itemName)
							invForceFilters[i].merge({"ID": newID})

		inv.forceFilters = invForceFilters

		inv.blacklist = data.get("Blacklist", false)

	var inv2 = get_parent().get_node_or_null("weapon_configuration")
	if inv2:
		var inv2InventoryData = data.get("InventoryData2", [])

		if Global.foundConvertFormat < 1:
			if inv2InventoryData != []:
				for i in inv2InventoryData:
					if i != null:
						var itemName = i.get("Name")
						if itemName:
							i.erase("Name")
							var newID = Global.convert_name(itemName)
							i.merge({"ID": newID})
		inv2.inventoryData = inv2InventoryData

		inv2.forceFilters = data.get("FilterData2", [null, null, null, null])

	for string in data:
		var variable = get_parent().get(string)
		if variable != null:
			get_parent().set(string, data[string])
