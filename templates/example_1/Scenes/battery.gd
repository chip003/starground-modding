class_name Battery extends Buildable

@export var maxPowerLevel = 100.0
var powerLevel = 0.0

func get_custom_class(): return "Battery"

func _process(delta):
	if multiplayer.is_server():
		if powerLevel >= maxPowerLevel:
			$mainSprite.set_frame_and_progress(3, 0)
		elif powerLevel > maxPowerLevel * 0.5:
			$mainSprite.set_frame_and_progress(2, 0)
		elif powerLevel > 0:
			$mainSprite.set_frame_and_progress(1, 0)
		else:
			$mainSprite.set_frame_and_progress(0, 0)

		if hasBuildLanded:
			if is_instance_valid(powerCoil) && is_instance_valid(powerCoil.powerNetwork):
				if powerCoil.powerNetwork.demand < 0:
					if powerLevel < maxPowerLevel:
						powerGeneration = 0.0
						if abs(powerCoil.powerNetwork.demand) > 0 && powerCoil.powerNetwork.batteryCount > 0:
							powerConsumption = abs(powerCoil.powerNetwork.demand) / powerCoil.powerNetwork.batteryCount
						else:
							powerConsumption = 0.0
						powerLevel += powerConsumption * delta
					else:
						powerConsumption = 0.0
				elif powerCoil.powerNetwork.demand > 0:
					if powerLevel > 0:
						if abs(powerCoil.powerNetwork.demand) > 0 && powerCoil.powerNetwork.batteryCount > 0:
							powerGeneration = powerCoil.powerNetwork.demand / powerCoil.powerNetwork.batteryCount
						else:
							powerGeneration = 0
						powerConsumption = 0.0
						powerLevel -= powerGeneration * delta
					else:
						powerGeneration = 0.0
				else:
					powerGeneration = 0.0
					powerConsumption = 0.0
			else:
				powerConsumption = 0.0
				powerGeneration = 0.0
