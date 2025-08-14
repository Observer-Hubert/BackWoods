extends Area2D

func _ready():
	body_entered.connect(_check_Player_Entered)
	body_exited.connect(_check_Player_Exited)

func _check_Player_Entered(body):
	if body.name == "Player":
		Bus.player_bush_collision_update(self)

func _check_Player_Exited(body):
	if body.name == "Player":
		Bus.player_bush_collision_update(null)
