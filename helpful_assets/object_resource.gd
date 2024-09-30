class_name ObjectResource extends Breakable

## This class is a parent class of all resources that spawn in the world
## It will automatically handle despawning

var lifespan = randi_range(30,120)
var despawn = true
var startFade = false
var fadeTween : Tween
var timer : Timer

func _ready():
	super._ready()
	if isServer:
		timer = Timer.new()
		add_child(timer)
		get_tree().call_group("Collector","check_resource",self)
		if despawn:
			timer.timeout.connect(start_fade)
		_reset_lifespan()


func start_fade():
	fade.rpc(true)


func _reset_lifespan():
	lifespan = randi_range(30,120)
	if isServer:
		fade.rpc(false) 
		timer.start(lifespan)


@rpc("call_local")
func fade(start):
	if start:
		fadeTween = get_tree().create_tween()
		fadeTween.tween_property(self, "modulate", Color(1,1,1,0), 1)
		fadeTween.tween_callback(queue_free)
		$DecayParticles.emitting = true
	else:
		if fadeTween:
			if fadeTween.is_valid():
				fadeTween.kill()
		
		$DecayParticles.emitting = false
		modulate.a = 1
