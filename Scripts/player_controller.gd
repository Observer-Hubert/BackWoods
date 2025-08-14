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
const EXHAUSTEDREGENMOD: float = 0.9

enum states{FREE_MOVEMENT, HIDING, AIMING}

var stamina: float = STAMMAX
var exhausted: bool = false
var state = states.FREE_MOVEMENT

func _input(event):
	if event.is_action_pressed("Aim") and state != states.AIMING:
		state = states.AIMING
		Bus.player_state_update(state)
	elif event.is_action_pressed("Aim") and state == states.AIMING:
		$PlayerLight.flash()
	elif event.is_action_pressed("Cancel") and state == states.AIMING:
		state = states.FREE_MOVEMENT
		Bus.player_state_update(state)

func _physics_process(delta):
	var baseVect = Input.get_vector("Left","Right","Up","Down")
	var desiredVel = baseVect * Vector2(SPEED, SPEED * YSPEEDMOD)
	if Input.is_action_pressed("Sprint") and exhausted == false and desiredVel.x + desiredVel.y != 0:
		desiredVel *= SPRINTSPEEDMOD
		stamina -= SPRINTSTAMCOST * delta
		if stamina <= 0:
			exhausted = true
	elif stamina < STAMMAX:
		stamina += STAMREGEN * (1.0 - (EXHAUSTEDREGENMOD * int(exhausted))) * delta
	else:
		exhausted = false
	Bus.stamina_update(stamina, exhausted)
	velocity = velocity.move_toward(desiredVel, ACCEL)
	if state == states.FREE_MOVEMENT:
		move_and_slide()
		Bus.player_pos_update(position)
