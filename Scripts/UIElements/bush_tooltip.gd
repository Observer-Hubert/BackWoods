extends TextureRect

# FADETIME is the time in seconds that it takes the Tooltip to fade in and out.
const FADETIME: float = 0.5
const MINOPACITY: float = 0.0
const MAXOPACITY: float = 0.7

func _ready() -> void:
	# The Tooltip should be invisible to start so that it only displays when it is accurate.
	modulate.a = MINOPACITY
	Bus.player_interactable_collision.connect(_update_Visibility)

#This UI element ought to be invisible if the player is not colliding with a bush
func _update_Visibility(bush: Node2D) -> void:
	# We use a tween here because the animation has to be modular, needing to be able to fade in or out from different opacity values.
	var tween: Tween = get_tree().create_tween()
	if bush == null:
		tween.tween_property(self, "modulate", Color(1,1,1,MINOPACITY), FADETIME)
	else:
		tween.tween_property(self, "modulate", Color(1,1,1,MAXOPACITY), FADETIME)
