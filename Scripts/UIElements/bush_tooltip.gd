extends Label

const FADETIME: float = 0.5

func _ready() -> void:
	modulate.a = 0.0
	Bus.player_bush_collision_updated.connect(_update_Visibility)

#This UI element ought to be invisible if the player is not colliding with a bush
func _update_Visibility(bush: Node2D) -> void:
	var tween: Tween = get_tree().create_tween()
	if bush == null:
		tween.tween_property(self, "modulate", Color(1,1,1,0), FADETIME)
	else:
		tween.tween_property(self, "modulate", Color(1,1,1,1), FADETIME)
