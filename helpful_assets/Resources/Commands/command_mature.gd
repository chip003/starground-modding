extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	
	if args.size() > 1:
		var main = root.get_node("/root/Multiplayer")
		
		if args[1] == "true":
			for animal in root.get_tree().get_nodes_in_group("Animals"):
				animal.set_growth.rpc(true)
			main.send_chatbox_message.rpc("", "[color=lightgray]Made all animals adults", false)
			return
		elif args[1] == "false":
			for animal in root.get_tree().get_nodes_in_group("Animals"):
				animal.set_growth.rpc(false)
			main.send_chatbox_message.rpc("", "[color=lightgray]Made all animals babies", false)
			return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /mature true|false", false)
