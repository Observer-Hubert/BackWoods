extends Control

const posOffset: Vector2 = Vector2(0.0, -32.0)

func _ready() -> void:
	Bus.player_pos_updated.connect(_update_Pos)

func _update_Pos(newPos: Vector2) -> void:
	position = newPos + posOffset
