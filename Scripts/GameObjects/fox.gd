extends Animal

@onready var behavior_timer: Timer = $BehaviorTimer

# If the fox stands still for for TIMEIDLINGTOSIT seconds, it moves to the sitting state.
const TIMEIDLINGTOSIT: float = 7.5

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_set_Vel)
	change_State(animalStates.IDLE)
	behavior_timer.timeout.connect(_random_State)
	behavior_timer.start(behavior_Interval)

# Placeholder for now, states ought to have some more rhyme and reason than the fox just randomly standing and running.
func _random_State() -> void:
	#var state_Index = randi_range(animalStates.values().min(),animalStates.values().max()-2)
	var state_Index = 1
	change_State(state_Index as animalStates)
	behavior_timer.start(behavior_Interval)

func _check_Sit() -> void:
	if currentState == animalStates.IDLE:
		change_State(animalStates.IDLE)
		behavior_timer.start(behavior_Interval)

func _idle_State_Setup() -> void:
	sprite.play("Standing")
	# A timer is set to check if we are still standing, after out time to sit interval, and should begin to sit.
	var sit_Timer = get_tree().create_timer(TIMEIDLINGTOSIT)
	sit_Timer.timeout.connect(_check_Sit)

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	pass
