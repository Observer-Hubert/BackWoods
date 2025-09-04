extends Area2D

@export var next_screen_Scene_Name: String = "forest_scene"

var fired: bool = false

func _ready() -> void:
	body_entered.connect(_next_Screen)

func _next_Screen(body: Node2D) -> void:
	if body is Player and not fired:
		fired = true
		Bus.request_Fade_Out(next_screen_Scene_Name)
