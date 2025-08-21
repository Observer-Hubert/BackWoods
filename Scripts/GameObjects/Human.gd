extends AnimatableBody2D

class_name Human

@export var photo_Data: PhotoData

# Called when the node enters the scene tree for the first time.
func _ready():
	$EarlSprite.play("default")
