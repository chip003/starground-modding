extends Node

func _init(root : Window, args : PackedStringArray) -> void:
	if args.size() == 3:
		if args[1].is_valid_float() && args[2].is_valid_float():
			if Global.activePlayer:
				Global.activePlayer.velocity = Vector2.ZERO
				Global.activePlayer.global_position = Vector2(args[1].to_float(), args[2].to_float())
				Global.activePlayer.get_node("Camera").reset_smoothing()
				var regionID = ModAPI.get_region_id_at_position(Global.activePlayer.global_position)
				Global.set_region(regionID)
				Global.stop_music()
				#print("Teleported to " + str(Global.activePlayer.global_position))
				root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Teleported to " + str(Global.activePlayer.global_position), false)
				return
				
	root.get_node("/root/Multiplayer").send_chatbox_message("", "[color=lightgray]Failed to run command. Proper usage: /tp <x> <y>", false)
