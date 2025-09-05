class_name Human extends AnimatableBody2D

@export var sprite: AnimatedSprite2D
@export var photo_Data: PhotoData

func _ready() -> void:
	sprite.animation_changed.connect(_check_Laugh)

func _check_Laugh() -> void:
	var newAnim = sprite.animation
	if newAnim == "Laughing":
		$Laugh.play()
