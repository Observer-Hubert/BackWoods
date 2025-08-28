extends Node

var screen_filter: bool = true

signal scren_filter_changed

func set_screen_filter(setting:bool) -> void:
	screen_filter = setting
	scren_filter_changed.emit(screen_filter)
