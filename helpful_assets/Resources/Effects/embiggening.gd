extends Object

var entity : Entity

var hasGrown = false

func _process(_delta) -> void:
	if !hasGrown:
		var tween = entity.get_tree().create_tween()
		tween.tween_property(entity.mainSprite, "scale", Vector2(2,2), 1.0)
		hasGrown = true
	else:
		entity.mainSprite.scale = Vector2(2,2)


func on_clear():
	var tween = entity.get_tree().create_tween()
	tween.tween_property(entity.mainSprite, "scale", Vector2(1,1), 1.0)
