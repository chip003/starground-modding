extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		var main = root.get_node("/root/Multiplayer")
		
		if Global.activePlayer:
			if args[1].is_valid_float():
				Global.activePlayer.miningTime = args[1].to_float()
				Global.activePlayer.miningTimer = 0.0
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Mining speed set to " + args[1], false)
				return

	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /miningspeed <value>", false)
