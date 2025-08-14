extends CharacterBody2D

const SPEED: float = 150.0
const YSPEEDMOD: float = 0.75
const SPRINTSPEEDMOD: float = 2.5
const ACCEL: float = 25.0
const STAMMAX: float = 100.0
const SPRINTSTAMCOST: float = 1.0
const STAMREGEN: float = 2.0

var stamina: float = STAMMAX
var exhausted: bool = false

func _physics_process(_delta):
	var baseVect = Input.get_vector("Left","Right","Up","Down")
	var desiredVel = baseVect * Vector2(SPEED, SPEED * YSPEEDMOD)
	if Input.is_action_pressed("Sprint") and exhausted == false:
		desiredVel *= SPRINTSPEEDMOD
		stamina -= SPRINTSTAMCOST
		if stamina <= 0:
			exhausted = true
	elif stamina < STAMMAX:
		stamina += STAMREGEN
	else:
		exhausted = false
	Bus.stamina_update(stamina)
	velocity = velocity.move_toward(desiredVel, ACCEL)
	move_and_slide()
