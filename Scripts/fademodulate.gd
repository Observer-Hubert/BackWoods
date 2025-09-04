extends CanvasModulate

@export var desiredModulateColor: Color

const DEFAULTFADETIME = 0.5

var nextSceneName: String

func _ready() -> void:
	Bus.fade_out.connect(fade_Out)
	fade_In()

func fade_Out(sceneName: String, time: float = DEFAULTFADETIME) -> void:
	nextSceneName = sceneName
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",Color(0.0,0.0,0.0,1.0),time)
	tween.tween_callback(_next_Scene)

func fade_In(time: float = DEFAULTFADETIME) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color",desiredModulateColor,time)

func _next_Scene():
	Bus.request_change_scene(nextSceneName)
