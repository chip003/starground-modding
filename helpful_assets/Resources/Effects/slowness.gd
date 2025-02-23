extends Object

var entity : Entity

func _process(_delta: float) -> void:
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(0.75,0.75,1.0)
		
	entity.speedEffectModifier = 0.25


func on_clear():
	entity.speedEffectModifier = 1.0
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1,1,1,1)
