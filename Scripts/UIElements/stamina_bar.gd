extends ProgressBar

# We use an animation player here because this node uses a rigid animation (it always fades from fully opaque).
@onready var anim_Player = $StaminaBarAnimPlayer

func _update_Value(newValue: float, exhausted: bool) -> void:
	value = newValue
	# If the stamina is not being used, we fade the display out, but we only want to do this once, so we check if it has already been faded out.
	if value == 100.0 and modulate.a != 0:
		anim_Player.play("fade_out")
	# The RESET animation makes the stamina bar fully visible.
	elif value < 100.0:
		anim_Player.play("RESET")
	# Sets the text to red if the player is exhausted.
	if exhausted == true:
		set("theme_override_colors/font_outline_color", Color(1,0,0,1))
	else:
		set("theme_override_colors/font_outline_color", null)

func _ready() -> void:
	modulate.a = 0.0
	Bus.stamina_updated.connect(_update_Value)
