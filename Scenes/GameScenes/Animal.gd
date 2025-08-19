extends Creature

class_name Animal

##Determines how often the animal considers new behavior.
@export_range(0.01,10.0) var behavior_Interval: float = 0.5

enum animalStates{STANDING, MOVING, SITTING}

var currentState: animalStates = animalStates.STANDING

# Takes one of the states and calls the corresponding setup function.
func change_State(newState: animalStates) -> void:
	match newState:
		animalStates.STANDING:
			_standing_State_Setup()
		animalStates.MOVING:
			_moving_State_Setup()
		animalStates.SITTING:
			_sitting_State_Setup()
	currentState = newState

#These will be overwritten by inheriting classes, and provide functionality to the states, being called on a corresponding state change.
func _standing_State_Setup() -> void:
	pass

func _moving_State_Setup() -> void:
	pass

func _sitting_State_Setup() -> void:
	pass
