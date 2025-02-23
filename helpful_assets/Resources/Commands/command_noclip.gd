extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	var main = root.get_node("/root/Multiplayer")
	if args.size() == 2:
		if Global.activePlayer:
			if args[1] == "true":
				Global.noclip = true
				main.send_chatbox_message("", "[color=lightgray]Enabled noclip", false)
				return
			elif args[1] == "false":
				Global.noclip = false
				main.send_chatbox_message("", "[color=lightgray]Disabled noclip", false)
				return

	main.send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /noclip <true/false>", false)
