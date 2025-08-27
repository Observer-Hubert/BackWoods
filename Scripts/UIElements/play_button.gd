extends Button

func _ready() -> void:
	pressed.connect(Bus.request_change_scene.bind("Forest_Scene"))
