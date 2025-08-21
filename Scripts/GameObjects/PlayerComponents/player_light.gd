extends PointLight2D

const MAXFLASHSIZE: float = 5.0
const MINFLASHSIZE: float = 2.0
const FLASHTICK: float = 5.0

var flashing: bool = false
var flashtimer: float

func flash() -> void:
	flashtimer = MAXFLASHSIZE
	flashing = true

func _process(delta: float) -> void:
	if flashing == true:
		scale = Vector2(flashtimer,flashtimer)
		flashtimer -= delta * FLASHTICK
		if flashtimer <= MINFLASHSIZE:
			flashing = false
			scale = Vector2(MINFLASHSIZE, MINFLASHSIZE)
