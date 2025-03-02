class_name Rock extends ObjectResource

## This is a parent class for all rocks
## It will start a shaking spawning animation, and set a few other standard variables
## Requires mainSprite to be a mask with a child sprite (the one that's displayed) called Rock

var customTween = true

func _ready():
	super()
	sound = "res://Sounds/Sound Effects/mine_rock.wav"


@rpc("call_local")
func _regenerate():
	super()
	shakeX = 6
	start_hit_shake()
	if customTween:
		$mainSprite/Rock.position.y = 8
		var tween = get_tree().create_tween()
		tween.tween_property($mainSprite/Rock, "position", Vector2(0,-8),0.5)
