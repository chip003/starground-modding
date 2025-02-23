extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() >= 2:
		var main = root.get_node("/root/Multiplayer")
		if args[1] == "all":
			for i in Global.researchTable:
				main.set_research.rpc_id(1, i, true)
			root.get_node("/root/Multiplayer").send_chatbox_message.rpc("", "[color=lightgray]Completed all research", false)
			return
		elif Global.researchTable.has(args[1]):
			if args.size() == 3 && args[2].is_valid_int():
				main.set_research.rpc_id(1, args[1], true, args[2].to_int())
			else:
				main.set_research.rpc_id(1, args[1], true)
			root.get_node("/root/Multiplayer").send_chatbox_message.rpc("", "[color=lightgray]Completed research " + args[1], false)
			return

	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /research <researchID>|all <researchLevel>", false)
