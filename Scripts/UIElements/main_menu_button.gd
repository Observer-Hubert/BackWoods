extends Button

func _ready() -> void:
	pressed.connect(_go_Home)

func _go_Home() -> void:
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS)
	var effect = AudioServer.get_bus_effect(0,0)
	tween.tween_property(effect,"cutoff_hz", 0, 0.5)
	Bus.request_go_home()
