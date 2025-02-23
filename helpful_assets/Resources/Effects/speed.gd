extends Object

var entity : Entity

func _process(_delta: float) -> void:
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1.0,1.0,1.2)
		
	entity.speedEffectModifier = 1.5


func on_clear():
	entity.speedEffectModifier = 1.0
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1,1,1,1)
