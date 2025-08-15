extends CharacterBody2D

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

func _ready() -> void:
	Bus.player_pos_update(position)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Aim") and currentState != playerStates.AIMING:
		currentState = playerStates.AIMING
		Bus.player_state_update(currentState)
	elif event.is_action_pressed("Aim") and currentState == playerStates.AIMING:
		$PlayerLight.flash()
		Bus.signal_photo_taken()
	elif event.is_action_pressed("Cancel") and currentState == playerStates.AIMING:
		currentState = playerStates.FREE_MOVEMENT
		Bus.player_state_update(currentState)

func _physics_process(delta: float) -> void:
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
	if currentState == playerStates.FREE_MOVEMENT and movementInput:
		velocity = _calculate_move_vect(delta, inputVect, sprintInput)
		move_and_slide()
		Bus.player_pos_update(position)
	if stamina <= 0.0:
		exhausted = true
	Bus.stamina_update(stamina, exhausted)

func _calculate_move_vect(delta: float, inputVect: Vector2, sprinting: bool) -> Vector2:
	var desiredVel: Vector2 = inputVect * Vector2(SPEED, SPEED * YSPEEDMOD)
	if sprinting and exhausted == false:
		desiredVel *= SPRINTSPEEDMOD
		stamina -= SPRINTSTAMCOST * delta
	return desiredVel
