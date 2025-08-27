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
<<<<<<< HEAD
	if not _hide_Scan():
		if lastNoisePos.x < to_global(position).x:
			desiredPos = position + Vector2(1000.0, 0.0)
		else:
			desiredPos = position - Vector2(1000.0, 0.0)
=======
	if lastNoisePos.x > position.x:
		desiredPos = position - Vector2(1000.0,0.0)
	if lastNoisePos.x < position.x:
		desiredPos = position + Vector2(1000.0,0.0)
>>>>>>> parent of a7e235a (Added um animal moves around)
	sprite.play("Moving")
