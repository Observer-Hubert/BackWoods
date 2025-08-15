extends Camera2D

#Placeholder, puts it halfway to the end of the viewports width and height
func _ready() -> void:
	position = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"),ProjectSettings.get_setting("display/window/size/viewport_height"))/2
