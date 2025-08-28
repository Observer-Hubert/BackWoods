extends AnimatedSprite2D

func _ready() -> void:
	frame_changed.connect(_play_Step)

func _play_Step() -> void:
	if animation == "Calm_Walk":
		if frame == 0 or frame == 4:
			$"../StepAudio".play()
