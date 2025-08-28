extends CheckBox

func _ready() -> void:
	button_pressed = Settings.screen_filter
	toggled.connect(_update_Setting)
	Settings.scren_filter_changed.connect(_change_Toggled)

func _update_Setting(setting:bool) -> void:
	Settings.set_screen_filter(setting)

func _change_Toggled(setting:bool) -> void:
	button_pressed = setting
