extends TextureRect

@onready var play_button: Button = $"../PlayButton"
@onready var options_button: Button = $"../OptionsButton"

func _ready() -> void:
	play_button.mouse_entered.connect(_highlight_Play)
	play_button.mouse_exited.connect(_reset)
	options_button.mouse_entered.connect(_highlight_Options)
	options_button.mouse_exited.connect(_reset)

func _reset() -> void:
	texture.region.position.x = 0

func _highlight_Play() -> void:
	texture.region.position.x += 480*1

func _highlight_Options() -> void:
	texture.region.position.x += 480*2
