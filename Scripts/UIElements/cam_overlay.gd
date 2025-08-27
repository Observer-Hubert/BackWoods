extends TextureRect

func _ready() -> void:
	Bus.player_state_updated.connect(_update_Visibility)

func _update_Visibility(state: int) -> void:
	if state == 2:
		visible = true
	else:
		visible = false
