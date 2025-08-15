extends Panel

func _ready() -> void:
	Bus.valid_photo_taken.connect(_update_Readout)

func _update_Readout(photo: PhotoData) -> void:
	$TextureRect.texture = photo.texture
	$Label.text = photo.caption
