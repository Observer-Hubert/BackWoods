extends Label

func _ready():
	Bus.player_state_updated.connect(_update_Text)

func _update_Text(state):
	if state == 0:
		text = "Free Movement"
	if state == 2:
		text = "Aiming"
