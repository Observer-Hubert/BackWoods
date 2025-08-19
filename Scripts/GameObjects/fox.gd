extends Animal

@onready var sprite: AnimatedSprite2D = $FoxSprite
@onready var behavior_timer: Timer = $BehaviorTimer

# If the fox stands still for for TIMEIDLINGTOSIT seconds, it moves to the sitting state.
const TIMEIDLINGTOSIT: float = 7.5

# desred_move_Vect stores a direction the fox would like to walk in.
var desired_Move_Vect: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	awareness_display = $AwarenessDisplay
	change_State(animalStates.STANDING)
	behavior_timer.timeout.connect(_random_State)
	behavior_timer.start(behavior_Interval)

func _process(delta: float) -> void:
	if observingPlayer == true:
		_change_Awareness(awarenessDelta * delta)
	if observingPlayer == false:
		_change_Awareness(-awareness_Decay_Rate)

# Placeholder for now, states ought to have some more rhyme and reason than the fox just randomly standing and running.
func _random_State() -> void:
	var state_Index = randi_range(animalStates.values().min(),animalStates.values().max()-1)
	change_State(state_Index as animalStates)
	behavior_timer.start(behavior_Interval)

func _check_Sit() -> void:
	if currentState == animalStates.STANDING:
		change_State(animalStates.SITTING)
		behavior_timer.start(behavior_Interval)

func _standing_State_Setup() -> void:
	sprite.play("Standing")
	# A timer is set to check if we are still standing, after out time to sit interval, and should begin to sit.
	var sit_Timer = get_tree().create_timer(TIMEIDLINGTOSIT)
	sit_Timer.timeout.connect(_check_Sit)

func _moving_State_Setup() -> void:
	# Placeholder, The fox ought to have locations it wants to go rather than just aimlessly wandering.
	desired_Move_Vect = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0)).normalized()
	# We flip the sprite if the fox is moving left, and reset it if it is moving right.
	if desired_Move_Vect.x < 0.0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	sprite.play("Moving")

func _sitting_State_Setup() -> void:
	sprite.play("Sitting")

func _physics_process(_delta: float) -> void:
	# The fox should only move if it is in the correct state.
	if currentState == animalStates.MOVING:
		velocity = velocity.move_toward(desired_Move_Vect * move_Speed, accel)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, accel)
	move_and_collide(velocity)
