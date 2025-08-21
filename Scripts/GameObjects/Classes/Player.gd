extends CharacterBody2D

class_name Player

@export var photo_Data: PhotoData

@onready var visibility_light: PointLight2D = $PlayerLight
@onready var sprite = $PlayerSprite
@onready var visibility_area = $PlayerVisibilityArea

const SPEED: float = 150.0 
const YSPEEDMOD: float = 0.75
const SPRINTSPEEDMOD: float = 2.5
#ACCEL is velocity acceleration per second.
const ACCEL: float = 1500.0
const STAMMAX: float = 100.0
#SPRINTSTAMCOST is how much stamina it costs to sprint per second
const SPRINTSTAMCOST: float = 100.0
#STAMREGEN is how much stamina the player regenerates per second while not running
const STAMREGEN: float = 25.0
#EXHAUSTEDREGENMOD * 100 percent of the stamina regen is subtracted from stamina regen when the player is exhausted
const EXHAUSTEDREGENMOD: float = 0.5

enum playerStates{FREE_MOVEMENT, HIDING, AIMING, IN_DIALOGUE, BUSY}

var stamina: float = STAMMAX
var exhausted: bool = false
var currentState: playerStates = playerStates.FREE_MOVEMENT
var previousStates: Array[playerStates]
var interactTarget: Node2D

func change_State(newState: playerStates) -> void:
	if currentState != null:
		previousStates.append(currentState)
	match newState:
		playerStates.FREE_MOVEMENT:
			currentState = playerStates.FREE_MOVEMENT
			sprite.play("Calm_Idle")
			Bus.request_cam_focus(self)
		playerStates.AIMING:
			currentState = playerStates.AIMING
			sprite.play("Calm_Raise_Cam")
			sprite.animation_finished.connect(func idleCam() -> void:
				sprite.play("Calm_Cam_Idle"))
		playerStates.HIDING:
			pass
		playerStates.IN_DIALOGUE:
			currentState = playerStates.IN_DIALOGUE
			sprite.play("Calm_Idle")
		playerStates.BUSY:
			currentState = playerStates.BUSY
			sprite.play("Calm_Idle")
	Bus.player_state_update(currentState)

func set_Interact_Target(newTarget: Node2D) -> void:
	interactTarget = newTarget
	Bus.signal_player_interactable_collision(interactTarget)

func clear_Interact_Target(oldTarget: Node2D) -> void:
	if oldTarget == interactTarget:
		interactTarget = null
		Bus.signal_player_interactable_collision(interactTarget)

func _ready() -> void:
	Bus.player_pos_update(position)
	Bus.request_cam_focus(self)
	Bus.dialogue_end.connect(_exit_Dialogue)
	Bus.cutscene_start.connect(_start_Cutscene)
	Bus.cutscene_end.connect(_end_Cutscene)
	sprite.play("Calm_Idle")

# Iterates through the previousStates array backwards, and returns the first non-busy state that is different from the current state.
func _get_Previous_State() -> playerStates:
	var length: int = previousStates.size()
	for i in range(0,length,1):
		print(length-(i+1))
		var value = previousStates[length-(i+1)]
		if previousStates[value] != currentState:
			if previousStates[value] != playerStates.BUSY:
				return previousStates[value]
	# If for some reason we cant find a previous state, we will return free movement as a default.
	return playerStates.FREE_MOVEMENT

func _exit_Dialogue() -> void:
	if currentState == playerStates.IN_DIALOGUE:
		change_State(_get_Previous_State())

func _start_Cutscene() -> void:
	change_State(playerStates.BUSY)

func _end_Cutscene() -> void:
	change_State(_get_Previous_State())

func _input(event: InputEvent) -> void:
	# The player should be powerless to exit the busy state
	if currentState != playerStates.BUSY:
		# If the player presses the aim key while not aiming, they move to the aiming state.
		if event.is_action_pressed("Aim") and currentState == playerStates.FREE_MOVEMENT:
			change_State(playerStates.AIMING)
		# If the player presses the aim key while aiming, they snap a picture.
		elif event.is_action_pressed("Aim") and currentState == playerStates.AIMING:
			visibility_light.flash()
			Bus.signal_photo_taken()
		# If the player presses the cancel input while aiming, they return to free movement.
		elif event.is_action_pressed("Cancel") and currentState == playerStates.AIMING:
			if _get_Previous_State() != currentState:
				change_State(_get_Previous_State())
			else:
				change_State(playerStates.FREE_MOVEMENT)
		elif event.is_action_pressed("Interact"):
			if currentState == playerStates.FREE_MOVEMENT:
				if interactTarget:
					if interactTarget is DialogueZone:
						Bus.pass_dialogue_event(interactTarget.dialoge_Data)
					change_State(playerStates.IN_DIALOGUE)
			elif currentState == playerStates.IN_DIALOGUE:
				Bus.skip_dialogue()

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
			var desiredVel: Vector2 = inputVect * Vector2(SPEED, SPEED * YSPEEDMOD)
			sprite.play("Calm_Walk")
			if sprintInput and not exhausted:
				desiredVel *= SPRINTSPEEDMOD
				stamina -= SPRINTSTAMCOST * delta
				sprite.speed_scale = 1.0 * SPRINTSPEEDMOD
				visibility_area.change_Visibility(2.5,2.5)
			else:
				visibility_area.change_Visibility(1.5,1.5)
				sprite.speed_scale = 1.0
			velocity = velocity.move_toward(desiredVel, ACCEL * delta)
			if velocity.x < 0.0:
				sprite.flip_h = false
			elif velocity.x > 0:
				sprite.flip_h = true
		else:
			sprite.play("Calm_Idle")
	#If the player is not moving or cannot move, we should decelerate their velocity.
	if currentState != playerStates.FREE_MOVEMENT or not movementInput:
		velocity = velocity.move_toward(Vector2.ZERO, ACCEL * delta)
		visibility_area.change_Visibility()
		sprite.speed_scale = 1.0
	#If the player's stamina is ever 0 or below, regardless of their current state, they should become exhausted.
	if stamina <= 0.0:
		exhausted = true
	# We need to update the UI on our stamina status.
	Bus.stamina_update(stamina, exhausted)
	#After everything has been calculated, we move the player by their velocity.
	move_and_slide()
	# We need to update the ui and reticle on our current position so they can follow.
	Bus.player_pos_update(position)
