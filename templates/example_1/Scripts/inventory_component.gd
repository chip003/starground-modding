class_name Inventory extends Node

#Script to add an inventory that can be accesed and displayed on client

@export var inventoryRows : int = 3
@export var inventoryColumns : int = 9
@export var stackSizeMultiplier : float = 1.0

@export var forceFilters = [null, null, null, null] #Filters for objects like movers
var blacklist : bool = false

##Internal array of stored items
@export var inventoryData : Array = []

##Whether the inventory is openable by players
@export var addToInventories : bool = false

##Name for inventory
@export var inventoryName : String = ""

##Path for custom display element
@export var displayOverride : String = ""

##Whether to open the player's inventory as well
@export var showPlayerInventory : bool = true

##Stores strings of item tag names that can be inserted into which slot.
#array of arrays
@export var slotFilters : Array = []
#example: [["starground:wood"], ["starground:stone"]]
#                slot 1                slot 2
##Indicates the amount of necessary materials
@export var slotAmounts : Array = []
##Stores true or false for each slot.
@export var canInsert : Array[bool] = []
##Stores true or false for each slot.
@export var canTake : Array[bool] = []
##Whether or not to do an initial resize (mainly for dynamic inventories)
@export var initialResize : bool = true
##Whether or not to fill the CANTAKEINSERT with false at start
@export var fillCanTakeInsert : bool = false
@export var canRename : bool = false

signal inventory_changed
signal item_added(item)

func _ready():
	set_multiplayer_authority(1)

	## A slot filled with FUEL_FILTER will filter to all fuels

	for i in range(slotFilters.size()):
		if slotFilters[i] is String:
			if slotFilters[i] == "FUEL_FILTER":
				slotFilters[i] = Global.fuelIDs

	if addToInventories:
		get_parent().add_to_group("Inventories")

	var totalSize = inventoryRows*inventoryColumns

	if initialResize:
		inventoryData.resize(totalSize)

	if fillCanTakeInsert:
		for i in range(inventoryData.size()):
			canInsert.push_back(false)
			canTake.push_back(false)


## Gets the total amount of a given item and name
@rpc("call_local", "any_peer")
func get_count(itemID) -> int:
	var count = 0
	if itemID != null:
		for i in inventoryData:
			if i != null:
				if i.ID == itemID:
					count += i.Amount

	return count


## Removes the given item and the given amount
func remove_amount(itemID, amount) -> bool:
	for i in range(inventoryData.size()):
		#if amount > 0:
		if inventoryData[i] != null:
			if inventoryData[i].ID == itemID:
				if amount >= inventoryData[i].Amount:
					amount -= inventoryData[i].Amount
					inventoryData[i] = null
				else:
					inventoryData[i].Amount -= amount
					if inventoryData[i].Amount == 0:
						inventoryData[i] = null
					inventory_changed.emit()
					return true
	return false


func subtract_index_amount(index, amount) -> void:
	if inventoryData[index] != null:
		inventoryData[index].Amount -= amount

		if inventoryData[index].Amount <= 0:
			inventoryData[index] = null

	inventory_changed.emit()


## Checks a given item to see if it can be inserted into the inventory and returns result
func check_item(item) -> bool:
	for i in range(inventoryData.size()):
		if canInsert.size() <= 0 || (canInsert.size() > 0 && canInsert[i]): #canInsert
			if check_slot_filter(i,item): #item slot has filter
				if inventoryData[i] == null:
					return true
				elif inventoryData[i].ID == item.ID:
					var stackSize = max(1, ModAPI.get_item_data(inventoryData[i].ID).StackSize*stackSizeMultiplier)

					if inventoryData[i].Amount < stackSize:
						return true

	return false


## Safely checks
func safe_check_item(item) -> bool:
	var newItem = item.duplicate(true)

	for i in range(inventoryData.size()):
		if canInsert.size() <= 0 || (canInsert.size() > 0 && canInsert[i]): #canInsert
			if check_slot_filter(i,item): #item slot has filter
				var stackSize = ModAPI.get_item_data(item.ID).StackSize*stackSizeMultiplier

				if inventoryData[i] == null:
					newItem.Amount -= stackSize
				elif inventoryData[i].ID == item.ID:
					newItem.Amount -= stackSize-inventoryData[i].Amount

				if newItem.Amount <= 0:
					return true

	return false


## Finds an item with given amount filter and id, and returns details in an array
func find_item(amountFilter = 0, idFilter = "") -> Array:
	for i in range(inventoryData.size()):
		var item = inventoryData[i]
		if item != null:
			if idFilter == "" || (idFilter != "" && item.ID == idFilter):
				if amountFilter > 0:
					if item.Amount > amountFilter:
						var newItem = item.duplicate(true)
						newItem.Amount = amountFilter
						return ["some",i, newItem]
					else:
						return ["all",i, item]
				else:
					return ["all",i, item]
	return ["none",-1, null]


## Finds an item, but also removes it on successful find
func get_item(amountFilter = 0, idFilter = ""):
	var result = find_item(amountFilter,idFilter)

	if result[0] != "none":
		var i = result[1]
		var item = inventoryData[i].duplicate(true)

		if result[0] == "some":
			item.Amount = amountFilter

			inventoryData[i].Amount -= amountFilter

			if inventoryData[i].Amount <= 0:
				inventoryData[i] = null

			inventory_changed.emit()

			return item

		elif result[0] == "all":
			inventoryData[i] = null
			inventory_changed.emit()
			return item

	return null


## Checks if item passes slot at given index
func check_slot_filter(index,item) -> bool:
	var readableList : PackedStringArray = []

	for i in forceFilters:
		if i != null:
			readableList.push_back(i.ID)

	if slotFilters.size() > 0:
		if slotFilters[index] is Array:
			for filter in slotFilters[index]:
				if item.ID == filter && (!blacklist || !readableList.has(item.ID)):
					return true
		else:
			if item.ID == slotFilters[index] && (!blacklist || !readableList.has(item.ID)):
				return true

	elif !blacklist || !readableList.has(item.ID):
		return true

	return false


func set_item(index, item) -> void:
	inventoryData[index] = item
	inventory_changed.emit()
	item_added.emit(item)


func add_to_index(index, id, amount) -> bool:
	if inventoryData[index] == null:
		inventoryData[index] = ModAPI.create_item_dict(id,amount)
		inventory_changed.emit()
		item_added.emit(ModAPI.create_item_dict(id, amount))
		return true
	elif inventoryData[index].ID == id:
		inventoryData[index].Amount += amount
		inventory_changed.emit()
		item_added.emit(ModAPI.create_item_dict(id, amount))
		return true

	return false

## Returns true or false depending upon whether an inventory is completely full or not
func is_full() -> bool:
	for i in range(inventoryData.size()):
		if inventoryData[i] != null:
			if inventoryData[i].Amount < ModAPI.get_item_data(inventoryData[i].ID).StackSize*stackSizeMultiplier:
				return false
		else:
			return false

	return true


## Checks if an inventory is empty or not
func is_empty() -> bool:
	for i in range(inventoryData.size()):
		if inventoryData[i] != null:
			return false

	return true


## Checks if an item can be added, and if so, adds the item, else returns false
func add_item(item) -> bool:
	var originalItem = item.duplicate(true)

	#if check_item(item):
	#look for stack first
	for i in range(inventoryData.size()):
		if inventoryData[i] != null:
			if check_slot_filter(i,item):
				if inventoryData[i].ID == item.ID: #item is the same
					var stackSize = max(1, ModAPI.get_item_data(inventoryData[i].ID).StackSize*stackSizeMultiplier)

					if inventoryData[i].Amount < stackSize:
						#item fully consumed
						if item.Amount <= stackSize - inventoryData[i].Amount:
							inventoryData[i].Amount += item.Amount
							item.Amount = 0
							inventory_changed.emit()
							item_added.emit(originalItem)
							return true
						else:
							var difference = (stackSize - inventoryData[i].Amount)
							inventoryData[i].Amount += difference
							item.Amount -= difference

	#add item to empty slot
	for i in range(inventoryData.size()):
		if inventoryData[i] == null:
			if check_slot_filter(i,item):
				var stackSize = max(1, ModAPI.get_item_data(item.ID).StackSize*stackSizeMultiplier)

				if item.Amount <= stackSize:
					inventoryData[i] = item.duplicate(true)
					item.Amount = 0
					inventory_changed.emit()
					item_added.emit(originalItem)
					return true
				else:
					inventoryData[i] = item.duplicate(true)
					inventoryData[i].Amount = stackSize
					item.Amount -= stackSize

	var difference = originalItem.Amount - item.Amount
	if difference > 0:
		originalItem.Amount = difference
		item_added.emit(originalItem)
		inventory_changed.emit()
	return false
