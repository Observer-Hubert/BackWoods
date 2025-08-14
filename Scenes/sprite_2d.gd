extends Sprite2D

func _ready():
	Bus.player_state_updated.connect(_update_Visibility)

func _update_Visibility(state):
	if state == 2:
		visible = true
	else:
		visible = false

func _process(delta):
	position = get_viewport().get_mouse_position()
