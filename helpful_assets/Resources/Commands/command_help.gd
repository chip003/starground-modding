extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 1:
		var commands : String = ""
		for i in Global.commandsTable:
			commands += i + " "
			
		root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Commands: " + commands, false)
		return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /help", false)
