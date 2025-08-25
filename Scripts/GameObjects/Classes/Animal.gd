extends Creature

class_name Animal

##Determines how often the animal considers new behavior.
@export_range(0.01,10.0) var behavior_Interval: float = 0.5
@export var curious: bool = false
@export var behavior_Origin: Vector2
@export_range(100.0, 1000.0, 10.0) var max_Dist_From_Origin = 250.0

enum animalStates{IDLE, FORAGING, INVESTIGATING, FLEEING}

var currentState: animalStates = animalStates.IDLE

func hear_Noise(noisePos: Vector2) -> void:
	super(noisePos)
	if curious == true:
		change_State(animalStates.INVESTIGATING)
	else:
		change_State(animalStates.FLEEING)

# Takes one of the states and calls the corresponding setup function.
func change_State(newState: animalStates) -> void:
	match newState:
		animalStates.IDLE:
			_idle_State_Setup()
		animalStates.FORAGING:
			_foraging_State_Setup()
		animalStates.INVESTIGATING:
			_investigating_State_Setup()
		animalStates.FLEEING:
			_fleeing_State_Setup()
	currentState = newState

func _random_Desired_Pos() -> void:
	desiredPos = Vector2(randf_range(-max_Dist_From_Origin,max_Dist_From_Origin), randf_range(-max_Dist_From_Origin,max_Dist_From_Origin))

func _physics_process(delta: float) -> void:
	print(currentAwareness)
	_update_Agent()
	_check_Flip()
	if reachedPos == false:
		move_and_collide(velocity * delta)
	if not observingPlayer:
		change_Awareness(-awareness_Decay_Rate * delta)

#These will be overwritten by inheriting classes, and provide functionality to the states, being called on a corresponding state change.
func _idle_State_Setup() -> void:
	pass

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	pass

func _fleeing_State_Setup() -> void:
	pass
