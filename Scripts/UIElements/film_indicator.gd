extends TextureRect

@onready var timer: Timer = $Timer

var frame: int = 1

const FRAMEINTERVAL: float = 0.2
const FRAMES: int = 3

func _ready() -> void:
	Bus.cam_loaded.connect(_update_Texture)
	timer.timeout.connect(_update_Texture.bind(false))

func _update_Texture(loaded:bool) -> void:
	if loaded == true:
		timer.stop()
		frame = 1
		texture.region.position.x = 0.0
	else:
		texture.region.position.x = 480.0 * frame
		timer.start(FRAMEINTERVAL)
		if frame < FRAMES:
			frame += 1
		else:
			frame = 1
