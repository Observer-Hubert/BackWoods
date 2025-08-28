class_name Human extends AnimatableBody2D

@export var sprite: AnimatedSprite2D
@export var photo_Data: PhotoData

func _ready() -> void:
	sprite.play("default")
