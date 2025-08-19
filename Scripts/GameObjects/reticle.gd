extends Area2D

# The reticle moves on a sort of "grid" as if it is on a digital readout of a camera.
const CELLSIZE: float = 8.0
const POSOFFSET: Vector2 = Vector2(CELLSIZE,-64.0)
# TIMEPERCELLMOVE is the amount of time in seconds between each possible cell movement of the reticle.
const TIMEPERCELLMOVE: float = 0.15
# CELLMOVEFASTMOD is multiplies TIMEPERCELLMOVE if the reticle is in fast mode.
const CELLMOVEFASTMOD: float = 0.25
# CELLMOVESTOFASTMOVE is the number of cell moves in a row the reticle must take to enter fast movement mode.
const CELLMOVESTOFASTMOVE: int = 3

var cellMoveTimer: float = TIMEPERCELLMOVE
# cellsMoved tracks how many cells in a row the reticle has moved without stopping.
var cellsMoved: int = 0
# startPos is the starting position of the reticle and tracks the player. This is needed so when the reticle is active it is not constantly calculating movements in the background.
var startPos: Vector2
#highlightSubject is the first highlightable subject among the overlapping bodies.
var highlightSubject: Node2D

func _ready() -> void:
	Bus.player_pos_updated.connect(_update_Position)
	Bus.player_state_updated.connect(_update_Visibility)
	Bus.photo_taken.connect(_scan_Valid_Photos)
	body_entered.connect(_check_Subject)
	body_exited.connect(_check_Subject)

func _update_Visibility(state: int) -> void:
	# State 2 is the player's Aiming state. The reticle should be active when the player is aiming.
	if state == 2:
		visible = true
		position = startPos
		Bus.request_cam_focus(self)
	else:
		position = Vector2(1000.0, 1000.0)
		visible = false

#_snap_To_Grid() ensures the coordinates of the passed vector 2 are divisible by the CELLSIZE, rounding them down to the nearest multiple.
func _snap_To_Grid(baseVector: Vector2) -> Vector2:
	var adjustedVector = baseVector / CELLSIZE
	adjustedVector = Vector2(floor(adjustedVector.x), floor(adjustedVector.y))
	adjustedVector *= CELLSIZE
	return adjustedVector

func _update_Position(newPos: Vector2) -> void:
	startPos = _snap_To_Grid(newPos + POSOFFSET)

# _scan_Valid_Photos() checks if the reticle's area is overlapping any bodies or areas that have photodata to pass to the readout.
func _scan_Valid_Photos() -> void:
	# We should only have one readout, so any valid body or area found ends the function.
	# Bodies (Animals or the player) Are preferred over photo zone areas, so they are checked first.
	for body in get_overlapping_bodies():
		if body is Animal or body is Player or body is Creature:
			Bus.signal_valid_photo_taken(body.photo_Data)
			return
	for area in get_overlapping_areas():
		if area is PhotoZone:
			Bus.signal_valid_photo_taken(area.photo_Data)
			return

# Called whenever a body enters or leaves the reticles area. Searches for a valid highlightable object among all overlapping bodies, and highlights the first one found, then exits the function.
func _check_Subject(_triggerer: Node2D) -> void:
	# We check all overlapping bodies if they are a 
	for body in get_overlapping_bodies():
		if body is Animal or body is Creature:
			for child in body.get_children():
				if child is AnimatedSprite2D:
					if child.material:
						if highlightSubject != body:
							if highlightSubject != null:
								highlightSubject.material.set_shader_parameter("active", false)
							highlightSubject = child
							highlightSubject.material.set_shader_parameter("active", true)
						return
	# If a valid subject is not found, we clear the highlightSubject's status, and remove the reference.
	if highlightSubject:
		highlightSubject.material.set_shader_parameter("active", false)
		highlightSubject = null

func _physics_process(delta: float) -> void:
	# We only need to be dealing with the reticle if it is currently active.
	if visible:
		cellMoveTimer -= delta
		# When the cellMoveTimer reaches 0, we should attempt to move to the cell the player is requesting.
		if cellMoveTimer <= 0.0:
			var moveInputVector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
			# We only need to perform movement code if the player is providing input.
			if moveInputVector.x != 0.0 or moveInputVector.y != 0.0:
				moveInputVector *= CELLSIZE
				position += moveInputVector
				# The reticle is in slow moving mode.
				if cellsMoved < CELLMOVESTOFASTMOVE:
					cellMoveTimer = TIMEPERCELLMOVE
				#the reticle is in fast moving mode. 
				else:
					cellMoveTimer = TIMEPERCELLMOVE * CELLMOVEFASTMOD
				cellsMoved +=1
			# If the reticle does not move for a tick, the moves in a row is reset.
			else:
				cellsMoved = 0
