extends PanelContainer

@onready var readout_texture = $ReadoutMargin/ReadoutVbox/PhotoPanel/ReadoutTexture
@onready var readout_caption = $ReadoutMargin/ReadoutVbox/CaptionCenter/ReadoutCaption
@onready var anim_player = $ReadoutAnimPlayer

var default_texture: Texture2D = load("res://Assets/Sprites/32x64standin.png")

func _ready() -> void:
	Bus.valid_photo_taken.connect(_update_Readout)
	anim_player.animation_finished.connect(_clear_Readout)

func _clear_Readout(_old_name: StringName):
	visible = false
	readout_texture.texture = default_texture
	readout_caption.text = ""

func _update_Readout(photo: PhotoData) -> void:
	# We want to ensure there is valid photo data.
	if photo:
		visible = true
		anim_player.play("RESET")
		anim_player.play("Print")
		readout_texture.texture = photo.texture
		readout_caption.text = photo.caption
