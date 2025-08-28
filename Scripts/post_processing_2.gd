extends Sprite2D

var in_cam: bool = false

func _ready() -> void:
	Bus.player_state_updated.connect(_change_Visibility)
	Settings.scren_filter_changed.connect(_disable_Visibility)

func _change_Visibility(state: int) -> void:
	if state == 2:
		in_cam = true
		if Settings.screen_filter == true:
			material.set_shader_parameter("screen_active", true)
	else:
		in_cam = false
		material.set_shader_parameter("screen_active", false)

func _disable_Visibility(setting: bool) -> void:
	if setting == false:
		material.set_shader_parameter("screen_active", false)
	elif in_cam == true:
		material.set_shader_parameter("screen_active", true)
