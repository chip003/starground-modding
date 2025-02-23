extends ObjectResource

## An example of another kind of resource that stems directly from ObjectResource

func _ready():
	super._ready()
	if isServer:
		dropData.push_back(ModAPI.create_item_dict("starground:wood", 2))
	sound = "res://Sounds/Sound Effects/mine_wood.wav"
	$mainSprite.material.set_shader_parameter("total_offset", global_position.x/48)
	

@rpc("call_local")
func _regenerate():
	super()
	scale = Vector2(0,0)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1,1), 4.0).set_trans(Tween.TRANS_SINE)
	

func _add_before_drop():
	if hitByPlayer:
		if randi_range(1,10) == 1:
			playerDrops.push_back(ModAPI.create_item_dict("starground:apple", 1))
