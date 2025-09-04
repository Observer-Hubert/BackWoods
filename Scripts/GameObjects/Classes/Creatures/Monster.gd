extends Creature

enum monsterStates{IDLE, STALKING, HUNTING}

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_set_Vel)
	navigation_agent.target_reached.connect(_target_Reached)
	max_awareness.connect(_hunt)

func _hunt() -> void:
	reachedPos = false
	sprite.play("Transformed_Run")
	desiredPos = lastNoisePos
