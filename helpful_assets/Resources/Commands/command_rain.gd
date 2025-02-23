extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 2:
		var main = root.get_node("/root/Multiplayer")
		if args[1] == "start":
			ModAPI.set_rain.rpc(0, 120)
			main.send_chatbox_message.rpc("", "[color=lightgray]Started rain", false)
			return
		elif args[1] == "stop":
			ModAPI.set_rain.rpc(120, 0)
			main.send_chatbox_message.rpc("", "[color=lightgray]Stopped rain", false)
			return
		
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /rain <start|stop>", false)
