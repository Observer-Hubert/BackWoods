extends Button

func _ready() -> void:
	pressed.connect(Bus.request_change_scene.bind("screen3"))
