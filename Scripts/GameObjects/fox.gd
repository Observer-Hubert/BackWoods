extends Animal

func _ready() -> void:
	desiredPos = position
	navigation_agent.velocity_computed.connect(_set_Vel)
	navigation_agent.target_reached.connect(_target_Reached)
	behavior_timer.timeout.connect(_renew_State)
	behavior_timer.start(behavior_Interval)
	change_State(animalStates.IDLE)

func _idle_State_Setup() -> void:
	sprite.play("Standing")
	if not _forage_Scan():
		_wander()

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	pass

func _fleeing_State_Setup() -> void:
	reachedPos = false
	if not _hide_Scan():
		if lastNoisePos.x < to_global(position).x:
			desiredPos = position + Vector2(1000.0, 0.0)
		else:
			desiredPos = position - Vector2(1000.0, 0.0)
	sprite.play("Moving")
