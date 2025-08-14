extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	Bus.player_bush_collision_updated.connect(_update_Visibility)

func _update_Visibility(bush):
	if bush == null:
		visible = false
	else:
		visible = true
