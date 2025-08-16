extends Panel

@onready var readout_texture = $ReadoutTexture
@onready var readout_caption = $ReadoutCaption
@onready var readout_timer = $ReadoutTimer

# READOUTTIME is the time in seconds that a readout will be visible for.
const READOUTTIME: float = 2.0

func _ready() -> void:
	Bus.valid_photo_taken.connect(_update_Readout)
	readout_timer.timeout.connect(_clear_Readout)

func _clear_Readout():
	visible = false
	readout_texture.texture = null
	readout_caption.text = ""

func _update_Readout(photo: PhotoData) -> void:
	visible = true
	readout_texture.texture = photo.texture
	readout_caption.text = photo.caption
	readout_timer.start(READOUTTIME)
