extends Node2D

@export var XSPEED = 250
@export var YSPEED = 100

func _process(delta):
	position.x += Input.get_axis("Left", "Right") * XSPEED * delta
	position.y += Input.get_axis("Up", "Down") * YSPEED * delta
