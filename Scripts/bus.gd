extends Node

#emitted when the players stamina changes
signal stamina_updated
#emitted when the player moves
signal player_pos_updated
#emitted when the camera position changes
signal camera_pos_updated
#emitted when a player collides or leaves the area of a bush, and passses the bush obejct
signal player_bush_collision_updated
#emitted when the player changes their state
signal player_state_updated
#emitted when a photo is attempted
signal photo_taken
#emitted when a valid photo is taken, passing the correct photo data
signal valid_photo_taken
#emitted when a node would like to become the camera's focus
signal cam_focus_request
#emitted when the player requests to exit the game
signal go_home
#emitted when the player requests to quit the game.
signal quit

func stamina_update(newValue: float, exhausted: bool) -> void:
	stamina_updated.emit(newValue, exhausted)

func player_pos_update(newPos: Vector2) -> void:
	player_pos_updated.emit(newPos)

func camera_pos_update(newPos: Vector2) -> void:
	camera_pos_updated.emit(newPos)

func player_bush_collision_update(bush: Node2D) -> void:
	player_bush_collision_updated.emit(bush)

func player_state_update(state: int) -> void:
	player_state_updated.emit(state)

func signal_photo_taken() -> void:
	photo_taken.emit()

func signal_valid_photo_taken(photo: PhotoData) -> void:
	valid_photo_taken.emit(photo)

func request_cam_focus(focus: Node2D) -> void:
	cam_focus_request.emit(focus)

func request_go_home() -> void:
	go_home.emit()

func request_quit() -> void:
	quit.emit()
