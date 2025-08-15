extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bus.player_bush_collision_updated.connect(_update_Visibility)

#This UI element ought to be invisible if the player is not colliding with a bush
func _update_Visibility(bush: Node2D) -> void:
	if bush == null:
		visible = false
	else:
		visible = true
