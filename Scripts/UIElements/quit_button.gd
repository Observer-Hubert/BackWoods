extends Button

func _ready() -> void:
	pressed.connect(_quit_Game)

func _quit_Game() -> void:
	Bus.request_quit()
