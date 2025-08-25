class_name AwarenessDisplay extends AnimatedSprite2D

var value: float = 0.0
var frames: float = 0.0

func _ready() -> void:
	frames = sprite_frames.get_frame_count("default")
	play("default")

func _process(_delta: float) -> void:
	set_frame_and_progress(int(floor((frames/100.0) * value)), 0.0)
