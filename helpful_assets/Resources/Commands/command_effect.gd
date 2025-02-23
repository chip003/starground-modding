extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	
	if args.size() > 1:
		var main = root.get_node("/root/Multiplayer")
		
		var setID
		
		if args[1] == "clear":
			if Global.activePlayer:
				Global.activePlayer.clear_effects()
				main.send_chatbox_message("", "[color=lightgray]Cleared all effects", false)
				return
				
		elif args.size() > 2:
			if args[2].split(":").size() > 1:
				setID = args[2]
			else:
				setID = "starground:effect_" + args[2]
			
			## Effect is not found in list
			if !Global.effectsTable.get(setID):
				main.send_chatbox_message("", "[color=lightgray]Effect " + setID + " not found!", false)
				return
			
			if args[1] == "add" && args.size() > 3:
				var time = 0.0
				
				if args[3] == "inf":
					time = INF
				else:
					if args[3].is_valid_float():
						time = args[3].to_float()
					else:
						main.send_chatbox_message("", "[color=lightgray]Length must be a valid number!", false)
						return
					
				if Global.activePlayer:
					Global.activePlayer.apply_effect(setID, time)
					main.send_chatbox_message("", "[color=lightgray]Applied effect " + setID + " for " + args[3] + " seconds", false)
					return
					
			elif args[1] == "remove":
				if Global.activePlayer:
					Global.activePlayer.remove_effect(setID)
					main.send_chatbox_message("", "[color=lightgray]Removed effect " + setID, false)
					return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /effect <add|remove|clear> <ID> <length>", false)
