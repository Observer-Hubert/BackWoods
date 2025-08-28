class_name Interactable extends Area2D

@export var photo_Data: PhotoData

func _ready() -> void:
	body_entered.connect(_check_Player_Entered)
	body_exited.connect(_check_Player_Exited)

func _check_Player_Entered(body: Node2D) -> void:
	if body is Player:
		body.set_Interact_Target(self)

func _check_Player_Exited(body: Node2D) -> void:
	if body is Player:
		body.clear_Interact_Target(self)
