extends Camera2D

const MOVESPEED: float = 750.0

# The subject is the Node the camera will attempt to follow.
var subject: Node2D = null
var in_Cutscene: bool = false
var reachedSubject: bool = false

@export var LBound: float
@export var RBound: float
@export var UBound: float
@export var DBound: float

func _update_Subject(newSubject: Node2D) -> void:
	_reset()
	reachedSubject = true
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
				if subject is Player:
					position.x = clamp(subject.position.x,LBound,RBound)
					position.y = clamp(subject.position.y,UBound,DBound)
				else:
					position = subject.position
			else:
				var vel = position.direction_to(subject.position).normalized() * MOVESPEED * delta
				position += vel
				if position.distance_to(subject.position) < 10.0:
					reachedSubject = true
	Bus.camera_pos_update(position)
