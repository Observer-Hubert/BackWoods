extends Node2D

@onready var flash_timer = $CameraFlashTimer

const FLASHTIME: float = 0.25

var camPos: Vector2

func _ready() -> void:
	Bus.camera_pos_updated.connect(_update_Cam_Pos)
	Bus.photo_taken.connect(_flash)
	flash_timer.timeout.connect(_hide_Flash)

func _hide_Flash() -> void:
	visible = false

func _flash() -> void:
	visible = true
	flash_timer.start(FLASHTIME)
	look_at(camPos)
	rotation_degrees += 90

func _update_Cam_Pos(newPos: Vector2) -> void:
	camPos = newPos
