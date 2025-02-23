extends Object

var entity : Entity

var effectTime = 1.0
var currentTime = effectTime
var particleEmitter

func _process(delta: float) -> void:
	if entity != null:
		if !particleEmitter:
			particleEmitter = load("res://Resources/Effects/heart_particles.tscn").instantiate()
			entity.add_child(particleEmitter)
			particleEmitter.emitting = true
	
	currentTime -= 1*delta
	
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1.0, 0.7, 0.9)
		
	if currentTime <= 0:
		currentTime = effectTime
		if entity.isServer:
			if entity.currentHP < entity.hp:
				entity.currentHP += 0.5
				entity.currentHP = clampf(entity.currentHP, 0, entity.hp)


func on_clear():
	particleEmitter.queue_free()
	if entity.mainSprite:
		entity.mainSprite.modulate = Color(1,1,1,1)
