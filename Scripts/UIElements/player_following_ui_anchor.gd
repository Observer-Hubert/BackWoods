extends Control

var viewportWidth: float = ProjectSettings.get_setting("display/window/size/viewport_width")
var viewportHeight: float = ProjectSettings.get_setting("display/window/size/viewport_height")
# posOffset is used to convert the control node's position to more closely reflect the 2d space's positions.
var posOffset: Vector2 = Vector2(0.0 + (viewportWidth/2), -32.0 + viewportHeight/2)
var camPos: Vector2
var playerPos: Vector2

func _ready() -> void:
	Bus.player_pos_updated.connect(_update_Player_Pos)
	Bus.camera_pos_updated.connect(_update_Camera_Pos)

func _update_Player_Pos(newPos: Vector2) -> void:
	playerPos = newPos
	_update_Pos()

# We need to know the camera position, so we can use it to offset our position so we can properly follow the player.
func _update_Camera_Pos(newPos: Vector2) -> void:
	camPos = newPos
	_update_Pos()

func _update_Pos() -> void:
	# We follow the player offset by the camera and our own position offset variable.
	position = playerPos - camPos + posOffset
