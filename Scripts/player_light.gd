extends PointLight2D

var flashing: bool = false
var flashtimer: float

func flash() -> void:
	flashtimer = 5.0
	flashing = true

func _process(delta: float) -> void:
	if flashing == true:
		scale = Vector2(flashtimer,flashtimer)
		flashtimer -= delta * 5.0
		if flashtimer <= 2.0:
			flashing = false
			scale = Vector2(2.0, 2.0)
