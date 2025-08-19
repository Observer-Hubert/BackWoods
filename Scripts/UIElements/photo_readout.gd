extends PanelContainer

@export var photo_Data: PhotoData

@onready var readout_texture = $ReadoutMargin/ReadoutVbox/PhotoPanel/ReadoutTexture
@onready var readout_caption = $ReadoutMargin/ReadoutVbox/CaptionCenter/ReadoutCaption
@onready var anim_player = $ReadoutAnimPlayer

var default_texture: Texture2D = load("res://Assets/Sprites/32x64standin.png")

func _ready() -> void:
	anim_player.play("RESET")
	anim_player.play("Print")
	readout_texture.texture = photo_Data.texture
	readout_caption.text = photo_Data.caption
	# When an animation finishes, the readout looks for what to do next.
	anim_player.animation_finished.connect(_finish_Anim)

func _finish_Anim(previous_Anim: StringName) -> void:
	# If the readout has finished printing, it should fall.
	if previous_Anim == "Print":
		anim_player.play("Fall")
	# If the readout has finsihed falling, it is no longer necessary.
	else:
		queue_free()
