extends Sprite2D

func _ready() -> void:
	Bus.player_state_updated.connect(_change_Visibility)

func _change_Visibility(state: int) -> void:
	if state == 2:
		material.set_shader_parameter("screen_active", true)
	else:
		material.set_shader_parameter("screen_active", false)
