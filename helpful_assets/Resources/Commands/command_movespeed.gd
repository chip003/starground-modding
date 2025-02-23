extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		var main = root.get_node("/root/Multiplayer")
		
		if Global.activePlayer:
			if args[1].is_valid_float():
				Global.activePlayer.speedCommandModifier = args[1].to_float()
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Speed set to " + args[1], false)
				return

	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /movespeed <value>", false)
