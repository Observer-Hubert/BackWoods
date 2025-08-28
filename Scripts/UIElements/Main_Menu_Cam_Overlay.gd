extends TextureRect

func _ready() -> void:
	visible = Settings.screen_filter
	Settings.scren_filter_changed.connect(_update_Visibility)

func _update_Visibility(setting: bool) -> void:
	if setting == true:
		visible = true
	else: 
		visible = false
