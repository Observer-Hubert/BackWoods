extends Label

# Will not remain in the final game. Dev tool only.

func _ready() -> void:
	Bus.player_state_updated.connect(_update_Text)

func _update_Text(state: int) -> void:
	if state == 0:
		text = "Free Movement"
	if state == 2:
		text = "Aiming"
