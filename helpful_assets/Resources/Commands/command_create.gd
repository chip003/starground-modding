extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		if args[1].ends_with(".tscn"):
			var main = root.get_node("/root/Multiplayer")
			if ResourceLoader.exists(args[1]):
				main.create_command.rpc_id(1,Global.activePlayer.global_position, args[1])
				return
	
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /create <filepath>", false)
