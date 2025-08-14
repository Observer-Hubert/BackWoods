extends Node

signal stamina_updated
signal player_pos_updated
signal player_bush_collision_updated

func stamina_update(newValue, exhausted):
	stamina_updated.emit(newValue, exhausted)

func player_pos_update(newPos):
	player_pos_updated.emit(newPos)

func player_bush_collision_update(bush: Node2D):
	player_bush_collision_updated.emit(bush)
