extends MarginContainer

@onready var anim_player = $PauseMenuAnimPlayer
@onready var resume_button = $MenuPanel/MenuPanelMargin/MenuVBox/QuitResumeHbox/ResumeButton

var active: bool = false

func _ready() -> void:
	resume_button.pressed.connect(_exit)
	position.x -= size.x

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and active == false:
		_enter()
	elif event.is_action_pressed("Pause") and active == true:
		_exit()

func _enter() -> void:
	anim_player.play("Enter")
	get_tree().paused = true
	active = true

func _exit() -> void:
	anim_player.play("Exit")
	get_tree().paused = false
	active = false
