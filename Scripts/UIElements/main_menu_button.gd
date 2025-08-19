extends Button

func _ready() -> void:
	pressed.connect(_go_Home)

func _go_Home() -> void:
	Bus.request_go_home()
