extends Control

const posOffset: Vector2 = Vector2(0, -32)

func _ready():
	Bus.player_pos_updated.connect(_update_Pos)

func _update_Pos(newPos):
	print(newPos)
	position = newPos + posOffset
