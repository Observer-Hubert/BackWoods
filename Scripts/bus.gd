extends Node

##emitted when the players stamina changes.
signal stamina_updated
##emitted when the player moves.
signal player_pos_updated
##emitted when the camera position changes.
signal camera_pos_updated
##emitted when a player collides or leaves the area of a bush, and passses the bush obejct.
signal player_interactable_collision
##emitted when the player changes their state.
signal player_state_updated
##emitted when a photo is attempted.
signal photo_taken
##emitted when a valid photo is taken, passing the correct photo data.
signal valid_photo_taken
##Emitted when the camera is loaded or unloaded
signal cam_loaded
##Emitted when the player generates a QTE
signal qte_generated
##Emitted when a QTE is complete, success or not.
signal qte_completed
##emitted when a node would like to become the camera's focus.
signal cam_focus_request
##emitted when the player requests to exit the game.
signal go_home
##emitted when the player requests to quit the game.
signal quit
##emitted when dialogue data is being passed to the UI.
signal dialogue_event
##emitted when the player attempts to skip dialogue.
signal dialogue_skip
##emitted when the current dialogue event ends.
signal dialogue_end
##Emitted when a cutscene is triggered
signal cutscene_trigger
##Emitted when a cutscene begins.
signal cutscene_start
##Emitted when a cutscene ends.
signal cutscene_end
##Emitted as a request to change the scene.
signal change_scene
##Emitted when a fadeout is requested
signal fade_out

func stamina_update(newValue: float, exhausted: bool) -> void:
	stamina_updated.emit(newValue, exhausted)

func player_pos_update(newPos: Vector2) -> void:
	player_pos_updated.emit(newPos)

func camera_pos_update(newPos: Vector2) -> void:
	camera_pos_updated.emit(newPos)

func signal_player_interactable_collision(bush: Node2D) -> void:
	player_interactable_collision.emit(bush)

func player_state_update(state: int) -> void:
	player_state_updated.emit(state)

func signal_photo_taken() -> void:
	photo_taken.emit()

func signal_valid_photo_taken(photo: PhotoData) -> void:
	valid_photo_taken.emit(photo)

func signal_cam_loaded(loaded:bool) -> void:
	cam_loaded.emit(loaded)

func signal_qte_generated(QTE: Array[String], time: float) -> void:
	qte_generated.emit(QTE, time)

func signal_qte_completed(success: bool) -> void:
	qte_completed.emit(success)

func request_cam_focus(focus: Node2D) -> void:
	cam_focus_request.emit(focus)

func request_go_home() -> void:
	go_home.emit()

func request_quit() -> void:
	quit.emit()

func pass_dialogue_event(dialogue: Array[DialogueData]) -> void:
	dialogue_event.emit(dialogue)

func skip_dialogue() -> void:
	dialogue_skip.emit()

func end_dialogue() -> void:
	dialogue_end.emit()

func trigger_cutscene(sceneName: String) -> void:
	cutscene_trigger.emit(sceneName)

func start_cutscene() -> void:
	cutscene_start.emit()

func end_cutscene() -> void:
	cutscene_end.emit()

func request_change_scene(sceneName: String) -> void:
	change_scene.emit(sceneName)

func request_Fade_Out(sceneName: String) -> void:
	fade_out.emit(sceneName)
