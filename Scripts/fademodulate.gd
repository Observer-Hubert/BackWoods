extends CanvasModulate

func _ready() -> void:
	fade_Out(1.0)

func fade_Out(time: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",Color(0.0,0.0,0.0,1.0),time)

func fade_In(time: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",Color(1.0,1.0,1.0,1.0),time)
