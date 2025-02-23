extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() > 1 && args.size() < 4:
		var main = root.get_node("/root/Multiplayer")
		var id : String
		var amount : int
		
		var tempID : String
		
		if args[1].split(":").size() > 1:
			tempID = args[1]
		else:
			tempID = "starground:" + args[1]
		
		if ModAPI.get_item_data(tempID).Name != "NAI":
			id = tempID
			if args.size() == 3:
				if args[2].is_valid_int():
					amount = args[2].to_int()
			else:
				amount = 1
				
			if amount:
				if Global.activePlayer:
					main.create_item.rpc_id(1, ModAPI.create_item_dict(id, amount), Global.activePlayer.global_position, 0)
					main.send_chatbox_message("", "[color=lightgray]Gave " + str(amount) + " of " + str(id), false)
					return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /give <ID> <Amount>", false)
