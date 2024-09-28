class_name Inventory extends Control

#Script to add an inventory that can be accesed and displayed on client

@export var inventoryRows = 3
@export var inventoryColumns = 9
@export var stackSizeMultiplier = 1.0

@export var forceFilters = [null, null, null, null] #Filters for objects like movers
var blacklist = false

##Internal array of stored items
@export var inventoryData = []

##Whether the inventory is openable by players
@export var addToInventories = false

##Name for inventory
@export var inventoryName = ""

##Path for custom display element
@export var displayOverride = ""

##Whether to open the player's inventory as well
@export var showPlayerInventory = true

##Stores strings of item tag names that can be inserted into which slot.
#array of arrays
@export var slotFilters = []
#example: [["Wood"], ["Stone"]]
#           slot 1     slot 2
##Indicates the amount of necessary materials
@export var slotAmounts = []
##Stores true or false for each slot.
@export var canInsert = []
##Stores true or false for each slot.
@export var canTake = []
##Whether or not to do an initial resize (mainly for dynamic inventories)
@export var initialResize = true
##Whether or not to fill the CANTAKEINSERT with false at start
@export var fillCanTakeInsert = false
@export var canRename = false

func _ready():
	set_multiplayer_authority(1)
	
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
func get_count(itemID):
	var count = 0
	if itemID != null:
		for i in inventoryData:
			if i != null:
				if i.ID == itemID:
					count += i.Amount
	
	return count
	

## Removes the given item and the given amount
func remove_amount(itemID, amount):
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
					return true
				
	return false
	
	
## Checks a given item to see if it can be inserted into the inventory and returns result
func check_item(item):
	for i in range(inventoryData.size()):
		if canInsert.size() <= 0 || (canInsert.size() > 0 && canInsert[i]): #canInsert
			if check_slot_filter(i,item): #item slot has filter
				if inventoryData[i] == null:
					return true
				elif inventoryData[i].ID == item.ID:
					var stackSize = max(1, Global.get_item_data(inventoryData[i].ID).StackSize*stackSizeMultiplier)
					
					if inventoryData[i].Amount < stackSize:
						return true
		
	return false


## Finds an item with given amount filter and id, and returns details in an array
func find_item(amountFilter = 0, idFilter = ""):
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
								
			return item
			
		elif result[0] == "all":
			inventoryData[i] = null
			return item
	
	return null


## Checks if item passes slot at given index
func check_slot_filter(index,item):
	var readableList = []
		
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
	
	
## Checks if an item can be added, and if so, adds the item, else returns false
func add_item(item):
	if check_item(item):
		#look for stack first
		for i in range(inventoryData.size()):
			if check_slot_filter(i,item):
				if inventoryData[i] != null:
					if inventoryData[i].ID == item.ID: #item is the same
						var stackSize = max(1, Global.get_item_data(inventoryData[i].ID).StackSize*stackSizeMultiplier)
						
						if inventoryData[i].Amount < stackSize:
							#item fully consumed
							if item.Amount <= stackSize - inventoryData[i].Amount:
								inventoryData[i].Amount += item.Amount
								return true
							else:
								var difference = (stackSize - inventoryData[i].Amount)
								inventoryData[i].Amount += difference
								item.Amount -= difference
		
		#add item to empty slot
		for i in range(inventoryData.size()):
			if check_slot_filter(i,item):
				if inventoryData[i] == null:
					var stackSize = max(1, Global.get_item_data(item.ID).StackSize*stackSizeMultiplier)
					
					if item.Amount <= stackSize:
						inventoryData[i] = item.duplicate(true)
						return true
					else:
						inventoryData[i] = item.duplicate(true)
						inventoryData[i].Amount = stackSize
						item.Amount -= stackSize
						return false
		
	else:
		return false
