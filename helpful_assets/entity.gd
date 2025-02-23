class_name Entity extends CharacterBody2D

@export_group("Stats")
@export var hp : float = 8.0
@export var attackRange : float = 16.0
@export var damage : float = 1.0
@export var cooldown : float = 0.35

var attackDamageModifier = 1.0

@export_group("Settings")
@export var canMove : bool = true
@export var iframeTime : float = 0.0
@export var playDeath : bool = true
## Effect IDs that entities are resistant to
@export var resistances : PackedStringArray = [] 
## Zero for infinite, otherwise lifespan in seconds
@export var corpseLifespan : float = 0.0

@export_group("Resources")
@export var damageSounds : Array[AudioStream] = []
@export var deathSounds : Array[AudioStream] = []
@export var deathSprite : Texture2D
@export var corpseOffset : Vector2 = Vector2.ZERO

@export_group("Hidden")
@export var currentHP : float = hp
@export var hasDied : bool = false
@export var velocitySync : Vector2 = Vector2.ZERO # a multiplayer variable for remembering velocity

var speedModifier : float = 1.0
var speedEffectModifier : float = 1.0
var speedVehicleModifier : float = 1.0
var speedCommandModifier : float = 1.0

signal damage_taken
signal has_died

var currentEffects : Dictionary = {} #effect name, current time remaining, only contains things that can actually be applied

@onready var mainSprite = get_node_or_null("mainSprite")

var slowedTimer : float = 0.0
var shakeX : float = 0.0
var isServer : bool = true
var isAuthority : bool = true
var currentiframeTime : float = 0.0

# Cooldown variables
var currentCooldown : float = cooldown
var knockback : Vector2 = Vector2.ZERO

@onready var synchronizer = get_node_or_null("MultiplayerSynchronizer")

var corpseScale = 1.0

func has_effect(effectID):
	return currentEffects.has(effectID)


@rpc("call_local")
func apply_effect(effectID, time):
	var effectData = Global.effectsTable.get(effectID)
	if effectData:
		if !currentEffects.has(effectID):
			
			var process = load(effectData.Resource).new()
			process.entity = self
			
			currentEffects.merge(
				{
					effectID: {
						"Time": time,
						"Process": process,
					}
				}
			)
		else:
			var effect = currentEffects.get(effectID)
			if effect:
				effect.Time = time


func remove_effect(effectID):
	var effect = currentEffects.get(effectID)
	if effect:
		effect.Process.on_clear()
	currentEffects.erase(effectID)


func _ready():
	currentHP = hp
	tree_exiting.connect(on_death)
	tree_exiting.connect(clear_effects)
	
	isServer = multiplayer.is_server()
	isAuthority = is_multiplayer_authority()


func clear_effects():
	var effectsList = []
	for i in currentEffects:
		effectsList.push_back(i)
	
	for i in effectsList:
		remove_effect(i)


func _process(delta):
	if is_multiplayer_authority():
		velocitySync = velocity
	
	for i in currentEffects:
		var effect = currentEffects.get(i)
		effect.Time -= 1*delta
		if effect.Time <= 0:
			remove_effect(i)
		else:
			effect.Process._process(delta)
	
	if currentiframeTime > 0:
		currentiframeTime -= 1*delta
	knockback = knockback.lerp(Vector2.ZERO,5*delta)
	
	if shakeX > 0.1:
		shakeX -= 2*delta
		$mainSprite.position.x = randf_range(-shakeX,shakeX)
	else:
		$mainSprite.position.x = 0
		

@rpc("call_local", "any_peer")
func play_sound(audioPlayer, override = true, pitchScale = 0):
	var ap = get_node_or_null(audioPlayer)
	
	if ap:
		if override || (!ap.playing):
			if audioPlayer == "takeDamage":
				if damageSounds.size() > 0:
					ap.stream = damageSounds.pick_random()
				
			if pitchScale != 0:
				ap.pitch_scale = pitchScale
			else:
				ap.pitch_scale = randf_range(0.75,1.5)
			ap.play()
	#else:
		#print("Sound player " + audioPlayer + " not found on " + str(self))


@rpc("call_local", "any_peer")
func take_damage(newDamage, newKnockback):
	if currentiframeTime <= 0:
		damage_taken.emit()
		currentiframeTime = iframeTime
		_on_hit()
		#print(str(self) + " has taken damage")
		play_sound("takeDamage")
		
		if is_multiplayer_authority():
			if self is Player:
				knockback = newKnockback
		
		if multiplayer.is_server():
			knockback = newKnockback*int(canMove)
			currentHP -= newDamage
			if currentHP <= 0:
				hasDied = true
				has_died.emit()


func _on_hit():
	pass
	
	
func _before_death():
	pass
	
	
func on_death():
	if playDeath:
		var corpse = load("res://Scenes/corpse.tscn").instantiate()
		corpse.global_position = global_position
		corpse.spriteOffset = corpseOffset
		corpse.scale = scale*corpseScale
		corpse.lifespan = corpseLifespan
		
		if deathSounds.size() > 0:
			corpse.deathSound = deathSounds.pick_random()
			
		if deathSprite:
			corpse.sprite = deathSprite
			
		var particles = get_node_or_null("HitParticles")
		if particles:
			corpse.particles = particles.duplicate()
			
		get_parent().add_child.call_deferred(corpse, true)
