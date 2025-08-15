extends Area2D

func _ready() -> void:
	Bus.player_state_updated.connect(_update_Visibility)
	Bus.photo_taken.connect(_scan_valid_photos)

func _update_Visibility(state: int) -> void:
	if state == 2:
		visible = true
	else:
		visible = false

func _scan_valid_photos() -> void:
	for body in get_overlapping_bodies():
		if body is Animal:
			Bus.signal_valid_photo_taken(body.photo_Data)

func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()
