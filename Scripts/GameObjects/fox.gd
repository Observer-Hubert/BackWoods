extends Animal

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_set_Vel)
	navigation_agent.target_reached.connect(_target_Reached)
	change_State(animalStates.IDLE)
	desiredPos = position

func _idle_State_Setup() -> void:
	sprite.play("Standing")

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	print("FUCK")

func _fleeing_State_Setup() -> void:
	reachedPos = false
	if lastNoisePos.x > position.x:
		desiredPos = position - Vector2(1000.0,0.0)
	if lastNoisePos.x < position.x:
		desiredPos = position + Vector2(1000.0,0.0)
	sprite.play("Moving")
