extends CharacterBody2D

class_name Player

@export var photo_Data: PhotoData

@onready var player_Light: PointLight2D = $PlayerLight
@onready var player_Sprite = $PlayerSprite

const SPEED: float = 150.0 
const YSPEEDMOD: float = 0.75
const SPRINTSPEEDMOD: float = 2.5
const ACCEL: float = 25.0
const STAMMAX: float = 100.0
#SPRINTSTAMCOST is how much stamina it costs to sprint per second
const SPRINTSTAMCOST: float = 100.0
#STAMREGEN is how much stamina the player regenerates per second while not running
const STAMREGEN: float = 25.0
#EXHAUSTEDREGENMOD * 100 percent of the stamina regen is subtracted from stamina regen when the player is exhausted
const EXHAUSTEDREGENMOD: float = 0.5

enum playerStates{FREE_MOVEMENT, HIDING, AIMING}

var stamina: float = STAMMAX
var exhausted: bool = false
var currentState: playerStates = playerStates.FREE_MOVEMENT

func change_State(newState: playerStates) -> void:
	match newState:
		playerStates.FREE_MOVEMENT:
			currentState = playerStates.FREE_MOVEMENT
			player_Sprite.play("Calm_Idle")
			Bus.request_cam_focus(self)
		playerStates.AIMING:
			currentState = playerStates.AIMING
			player_Sprite.play("Calm_Raise_Cam")
			player_Sprite.animation_finished.connect(func idleCam() -> void:
				player_Sprite.play("Calm_Cam_Idle"))
	Bus.player_state_update(currentState)

func _ready() -> void:
	Bus.player_pos_update(position)
	Bus.request_cam_focus(self)
	player_Sprite.play("Calm_Idle")

func _input(event: InputEvent) -> void:
	# If the player presses the aim key while not aiming, they move to the aiming state.
	if event.is_action_pressed("Aim") and currentState != playerStates.AIMING:
		change_State(playerStates.AIMING)
	# If the player presses the aim key while aiming, they snap a picture.
	elif event.is_action_pressed("Aim") and currentState == playerStates.AIMING:
		player_Light.flash()
		Bus.signal_photo_taken()
	# If the player presses the cancel input while aiming, they return to free movement.
	elif event.is_action_pressed("Cancel") and currentState == playerStates.AIMING:
		change_State(playerStates.FREE_MOVEMENT)

func _physics_process(delta: float) -> void:
	# We take input commands at the beginning to avoid redundant checks.
	var sprintInput: bool = Input.is_action_pressed("Sprint")
	var inputVect: Vector2 = Input.get_vector("Left","Right","Up","Down")
	# movementInput checks if any movement input key is pressed and stores that as a bool for checks later.
	var movementInput: bool = inputVect.x != 0.0 or inputVect.y != 0.0
	# We want the stamina to regen if the player is not sprinting. This includes when the player has the sprint key held, but is not moving as well as when the player cannot sprint due to exhaustion.
	if (not sprintInput or exhausted) or not movementInput:
		if stamina < STAMMAX:
			# increments stamina by the player's STAMINAREGEN modified by the EXHAUSTREGENMOD if the player is exhausted. This is clamped so the player cannot regen more than their stamina maximum.
			stamina = clampf(stamina + (STAMREGEN * (1.0 - (EXHAUSTEDREGENMOD * int(exhausted))) * delta), -STAMMAX, STAMMAX)
		# If the player is at full stamina, they are no longer exhausted.
		elif exhausted == true:
			exhausted = false
	# The player only needs movement code if they are allowed to move and are attempting to do so.
	if currentState == playerStates.FREE_MOVEMENT:
		if movementInput:
			player_Sprite.play("Calm_Walk")
			if sprintInput:
				player_Sprite.speed_scale = 1.0 * SPRINTSPEEDMOD
			else:
				player_Sprite.speed_scale = 1.0
			velocity = _calculate_move_vect(delta, inputVect, sprintInput)
			if velocity.x < 0.0:
				player_Sprite.flip_h = false
			elif velocity.x > 0:
				player_Sprite.flip_h = true
			move_and_slide()
		else:
			player_Sprite.play("Calm_Idle")
		# We need to update the ui and reticle on our current position so they can follow.
		Bus.player_pos_update(position)
	if stamina <= 0.0:
		exhausted = true
	# We need to update the UI on our stamina status.
	Bus.stamina_update(stamina, exhausted)

# Takes the player's input to calculate what their velocity should be.
# Also reduces the player's stamina if they are sprinting currently.
# was originally in the _physics_process(), but was moved out to clean it up.
func _calculate_move_vect(delta: float, inputVect: Vector2, sprinting: bool) -> Vector2:
	var desiredVel: Vector2 = inputVect * Vector2(SPEED, SPEED * YSPEEDMOD)
	if sprinting and exhausted == false:
		desiredVel *= SPRINTSPEEDMOD
		stamina -= SPRINTSTAMCOST * delta
	return desiredVel
