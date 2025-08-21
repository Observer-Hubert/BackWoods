extends Creature

class_name Animal

##Determines how often the animal considers new behavior.
@export_range(0.01,10.0) var behavior_Interval: float = 0.5
@export var curious: bool = false

enum animalStates{IDLE, FORAGING, INVESTIGATING, FLEEING}

var currentState: animalStates = animalStates.IDLE

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

#These will be overwritten by inheriting classes, and provide functionality to the states, being called on a corresponding state change.
func _idle_State_Setup() -> void:
	pass

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	pass

func _fleeing_State_Setup() -> void:
	pass
