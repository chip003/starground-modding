extends Node

#PROPERTY_USAGE_READ_ONLY

var entity : Entity

func _init(newEntity) -> void:
	entity = newEntity
	
	var bolt = load("res://Scenes/lightning_arc.tscn").instantiate()
	bolt.global_position = entity.global_position
	entity.get_parent().add_child(bolt, true)
	
	
	#var bomb = load("res://Scenes/bomb.tscn").instantiate()
	#bomb.global_position = entity.global_position
	#entity.get_parent().add_child(bomb,true)
