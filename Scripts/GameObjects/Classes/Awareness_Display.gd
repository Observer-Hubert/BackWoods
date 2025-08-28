class_name AwarenessDisplay extends AnimatedSprite2D

const FADETIME = 0.5

var value: float = 0.0
var frames: float = 0.0

func _ready() -> void:
	modulate = Color(1.0,1.0,1.0,0.0)
	frames = sprite_frames.get_frame_count("default")
	play("default")

func _process(_delta: float) -> void:
	set_frame_and_progress(int((frames/100.0) * value)-1, 0.0)
	if value == 0.0:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color(1.0,1.0,1.0,0.0), FADETIME)
	else:
		modulate = Color(1.0,1.0,1.0,1.0)
