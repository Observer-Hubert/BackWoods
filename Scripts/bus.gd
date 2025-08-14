extends Node

#emitted when the players stamina changes
signal stamina_updated
#emitted when the player moves
signal player_pos_updated
#emitted when a player collides or leaves the area of a bush, and passses the bush obejct
signal player_bush_collision_updated
#emitted when the player changes their state
signal player_state_updated

func stamina_update(newValue, exhausted):
	stamina_updated.emit(newValue, exhausted)

func player_pos_update(newPos):
	player_pos_updated.emit(newPos)

func player_bush_collision_update(bush: Node2D):
	player_bush_collision_updated.emit(bush)

func player_state_update(state):
	player_state_updated.emit(state)
