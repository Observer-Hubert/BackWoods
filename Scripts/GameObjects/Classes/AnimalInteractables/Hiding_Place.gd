class_name HidingPlace extends AnimalInteractable

@export var sprite: AnimatedSprite2D

var hide_Entry_Point: Vector2

func _ready() -> void:
	hide_Entry_Point = to_global($HideEntry.position)

func Hide() -> void:
	sprite.play("Hide")
