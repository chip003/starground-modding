extends Node

#PROPERTY_USAGE_READ_ONLY

var entity : Entity

func _init(newEntity) -> void:
	entity = newEntity
	
	var cloud = load("res://Scenes/poison_cloud_spawner.tscn").instantiate()
	cloud.global_position = entity.global_position
	entity.get_parent().add_child(cloud, true)
