class_name Rock extends ObjectResource

## This is a parent class for all rocks
## It will start a shaking spawning animation, and set a few other standard variables
## Requires mainSprite to be a mask with a child sprite (the one that's displayed) called Rock

func _ready():
	super()
	$mainSprite/Rock.position.y = 8
	sound = "res://Sounds/Sound Effects/mine_rock.wav"
	shakeX = 6
	start_hit_shake()
	
	var tween = get_tree().create_tween()
	tween.tween_property($mainSprite/Rock, "position", Vector2(0,-8),0.5)
