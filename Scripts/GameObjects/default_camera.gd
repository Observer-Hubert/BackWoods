extends Camera2D

const MOVESPEED: float = 750.0

# The subject is the Node the camera will attempt to follow.
var subject: Node2D = null
var in_Cutscene: bool = false
var reachedSubject: bool = false

func _update_Subject(newSubject: Node2D) -> void:
	_reset()
	reachedSubject = false
	subject = newSubject

func _reset() -> void:
	Bus.camera_pos_update(position)

func _ready() -> void:
	Bus.cam_focus_request.connect(_update_Subject)
	Bus.cutscene_start.connect(_entered_Cutscene)
	Bus.cutscene_end.connect(_exited_Cutscene)
	_reset()

func _entered_Cutscene() -> void:
	in_Cutscene = true

func _exited_Cutscene() -> void:
	in_Cutscene = false

func _process(delta) -> void:
	if not in_Cutscene:
		if subject != null:
			if reachedSubject:
				position.x = subject.position.x
				# The player should not affect the camera's y value, because of the structure of the forest being a hallway.
				if subject: # is not Player:
					position.y = subject.position.y
			else:
				var vel = position.direction_to(subject.position).normalized() * MOVESPEED * delta
				position += vel
				if position.distance_to(subject.position) < 10.0:
					reachedSubject = true
			Bus.camera_pos_update(position)
