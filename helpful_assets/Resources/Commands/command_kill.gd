extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 1:
		if Global.activePlayer:
			Global.activePlayer.take_damage.rpc_id(1, 999999999, Vector2.ZERO)
			root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Bye bye!", false)
			return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /kill", false)
