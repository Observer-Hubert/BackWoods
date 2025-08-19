extends AnimatableBody2D

class_name Creature

##This data is passed to the UI in the case that a picture is taken of this node.
@export var photo_Data: PhotoData
##Determines how quickly the creature becomes aware of the player.
@export_range(0.5,10.0,0.1) var awareness_Modifier: float = 1.0 
##Determines how fast the creature moves.
@export_range(0.01,5.0) var move_Speed: float = 1.0
##Determines how quickly the creature accelerates and decelerates.
@export_range(0.01,1.0) var accel: float = 0.1
##The rate in awareness per second that the animals awareness decays when not observing the player.
@export_range(1.0,10.0,0.1) var awareness_Decay_Rate: float = 1.0

##The maximum awareness value. having it just be 100 for now so it works niceley as a percentage.
const MAXAWARENESS: float = 100.0

var currentAwareness: float = 0.0
#True if the creature is currently observing the player.
var observingPlayer: bool = false
#The rate at which awareness is currently changing per second.
var awarenessDelta: float
#The node that visualizes the current awareness level of the creature.
var awareness_display: Control

#Emitted when the creature's awareness is updated.
signal awareness_updated
#Emitted when the creature's maximum awareness is reached.
signal max_awareness

#Changes awareness by the passed amount, and emits corresponding signals, then updates the visualizer.
func _change_Awareness(amount: float) -> void:
	currentAwareness = clamp(currentAwareness + (amount * awareness_Modifier), 0.0, MAXAWARENESS)
	awareness_updated.emit(currentAwareness)
	if currentAwareness == MAXAWARENESS:
		max_awareness.emit()
	if awareness_display != null:
		awareness_display.modulate.a = (currentAwareness/MAXAWARENESS)
