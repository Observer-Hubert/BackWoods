class_name Human extends AnimatableBody2D

@onready var sprite: AnimatedSprite2D = $EarlSprite

@export var photo_Data: PhotoData

func _ready():
	sprite.play("default")
