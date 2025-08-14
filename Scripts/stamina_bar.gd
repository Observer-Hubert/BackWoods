extends ProgressBar

func _update_Value(newValue, exhausted):
	value = newValue
	if value == 100:
		visible = false
	else:
		visible = true
	#Sets the text to red if the player is exhausted
	if exhausted == true:
		set("theme_override_colors/font_outline_color", Color(1,0,0,1))
	else:
		set("theme_override_colors/font_outline_color", null)

func _ready():
	Bus.stamina_updated.connect(_update_Value)
