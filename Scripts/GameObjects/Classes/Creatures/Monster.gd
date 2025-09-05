extends Creature

enum monsterStates{UNTRANSFORMED, IDLE, STALKING, HUNTING, STUNNED}

var currentState: monsterStates = monsterStates.UNTRANSFORMED

func change_state(newState: monsterStates) -> void:
	if currentState != monsterStates.UNTRANSFORMED:
		currentState = newState

func _check_Transform() -> void:
	var newAnim = sprite.animation
	if newAnim == "TransformFinished":
		_transform()
	if newAnim == "Scream":
		$ScreamAudio.play()
	if newAnim == "Transform":
		Bus.music_change.emit()

func _transform() -> void:
	busy = false
	currentState = monsterStates.IDLE

func _ready() -> void:
	desiredPos = position
	moveSpeed = base_Move_Speed
	sprite.animation_changed.connect(_check_Transform)
	navigation_agent.velocity_computed.connect(_set_Vel)
	navigation_agent.target_reached.connect(_target_Reached)
	max_awareness.connect(change_state.bind(monsterStates.HUNTING))

func _hunt() -> void:
	reachedPos = false
	sprite.play("Transformed_Run")
	desiredPos = lastNoisePos

func _process(_delta: float) -> void:
	if currentState == monsterStates.HUNTING:
		_hunt()
