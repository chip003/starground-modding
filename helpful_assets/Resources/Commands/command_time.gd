extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		var main = root.get_node("/root/Multiplayer")
		if args[1].is_valid_float():
			if args[1].to_float() <= main.dayLength && args[1].to_float() >= 0:
				var dayStart : float = floor(main.time/main.dayLength)*main.dayLength
				ModAPI.set_time.rpc_id(1, dayStart+args[1].to_float())
				root.get_node("/root/Multiplayer").send_chatbox_message.rpc("", "[color=lightgray]Set time to " + args[1], false)
				return
			else:	
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Time is invalid. Must be between 0 and " + str(main.dayLength), false)
				return

	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /time <time>", false)
