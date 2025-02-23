extends Object

var entity : Entity

func _process(_delta: float) -> void:
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(2.0,0.75,0.75)
	
	entity.attackDamageModifier = 2.0
		
	#entity.speedEffectModifier = 1.5


func on_clear():
	entity.attackDamageModifier = 1.0
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1,1,1,1)
