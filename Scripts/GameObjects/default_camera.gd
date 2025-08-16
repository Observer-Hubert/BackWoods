extends Camera2D

# The subject is the Node the camera will attempt to follow.
var subject: Node2D = null

func _update_Subject(newSubject: Node2D) -> void:
	_reset()
	subject = newSubject

func _reset() -> void:
	position = Vector2(0,0)
	Bus.camera_pos_update(position)

func _ready() -> void:
	Bus.cam_focus_request.connect(_update_Subject)
	_reset()

func _process(_delta) -> void:
	if subject != null:
		position.x = subject.position.x
		# The player should not affect the camera's y value, because of the structure of the forest being a hallway.
		if subject is not Player:
			position.y = subject.position.y
		Bus.camera_pos_update(position)
