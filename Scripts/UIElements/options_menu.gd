extends MarginContainer

@export var anim_player: AnimationPlayer
@export var exit_button: Button

var active: bool = false

func _ready() -> void:
	exit_button.pressed.connect(_exit)
	position.x -= size.x
	$"../OptionsButton".pressed.connect(_enter)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and active == true:
		_exit()

func _enter() -> void:
	anim_player.play("Enter")
	active = true

func _exit() -> void:
	anim_player.play("Exit")
	active = false
