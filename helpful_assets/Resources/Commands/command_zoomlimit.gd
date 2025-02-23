extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		var main = root.get_node("/root/Multiplayer")
		
		if Global.activePlayer:
			if args[1] == "true":
				Global.activePlayer.zoomLimit = true
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Enabled zoom limits", false)
				return
			elif args[1] == "false":
				Global.activePlayer.zoomLimit = false
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Disabled zoom limits", false)
				return

	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /zoomlimit <true/false>", false)
