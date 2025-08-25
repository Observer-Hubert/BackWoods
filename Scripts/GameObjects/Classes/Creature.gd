extends AnimatableBody2D

class_name Creature

##This data is passed to the UI in the case that a picture is taken of this node.
@export var photo_Data: PhotoData
@export_group("Awareness")
##Determines how quickly the creature becomes aware of the player.
@export_range(0.5,10.0,0.1) var awareness_Modifier: float = 1.0 
##The rate in awareness per second that the animals awareness decays when not observing the player.
@export_range(1.0,10.0,0.1) var awareness_Decay_Rate: float = 50.0

@export_group("Movement")
##Determines how fast the creature moves.
@export_range(10.0, 200.0, 5.0) var move_Speed: float = 150.0
##Determines how quickly the creature accelerates and decelerates per second.
@export_range(10.0, 2000.0, 10.0) var accel: float = 150.0

@export_group("Components")
##The Creature's sprite node
@export var sprite: AnimatedSprite2D
##The node that visualizes the current awareness level of the creature.
@export var awareness_display: AnimatedSprite2D
##The pathfinder node
@export var navigation_agent: NavigationAgent2D

##The maximum awareness value. having it just be 100 for now so it works niceley as a percentage.
const MAXAWARENESS: float = 100.0
##The minimum awareness value.
const MINAWARENESS: float = 0.0

var currentAwareness: float = 0.0
#True if the creature is currently observing the player.
var observingPlayer: bool = false
#Stores the last position the creature heard a loud sound at.
var lastNoisePos: Vector2
#False if the animal has investigated the last loud sound it heard.
var heardSomething: bool = false
#velocity is the current movement velocity of the creature.
var velocity: Vector2 = Vector2.ZERO
#desiredPos is the position the creature would like to be.
var desiredPos: Vector2
#reachedPos is true when the creature has met with its desired position.
var reachedPos: bool = false

#Emitted when the creature's awareness is updated.
signal awareness_updated
#Emitted when the creature's maximum awareness is reached.
signal max_awareness

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_set_Vel)
	navigation_agent.target_reached.connect(_target_Reached)

func hear_Noise(noisePos: Vector2) -> void:
	heardSomething = true
	lastNoisePos = noisePos

#Changes awareness by the passed amount, and emits corresponding signals, then updates the visualizer.
func change_Awareness(amount: float) -> void:
	currentAwareness = clamp(currentAwareness + (amount * awareness_Modifier), MINAWARENESS, MAXAWARENESS)
	awareness_updated.emit(currentAwareness)
	if currentAwareness == MAXAWARENESS:
		max_awareness.emit()
	if awareness_display != null:
		awareness_display.value = currentAwareness

func _check_Flip() -> void:
	if velocity:
		if velocity.x < 0.0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

func _update_Agent() -> void:
	if desiredPos != null:
		if navigation_agent != null:
			navigation_agent.target_position = desiredPos
			var dir = to_local(navigation_agent.get_next_path_position()).normalized()
			navigation_agent.velocity = dir * move_Speed

func _set_Vel(safe_vel: Vector2):
	velocity = safe_vel

func _target_Reached() -> void:
	reachedPos = true
