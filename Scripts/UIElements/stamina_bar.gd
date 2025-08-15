extends ProgressBar

@onready var anim_Player = $StaminaBarAnimPlayer

func _update_Value(newValue: float, exhausted: bool) -> void:
	value = newValue
	if value == 100.0 and modulate.a != 0:
		anim_Player.play("fade_out")
	elif value < 100.0:
		anim_Player.play("RESET")
	#Sets the text to red if the player is exhausted
	if exhausted == true:
		set("theme_override_colors/font_outline_color", Color(1,0,0,1))
	else:
		set("theme_override_colors/font_outline_color", null)

func _ready() -> void:
	modulate.a = 0.0
	Bus.stamina_updated.connect(_update_Value)
