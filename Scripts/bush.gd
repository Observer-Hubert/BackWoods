extends Area2D

func _ready() -> void:
	body_entered.connect(_check_Player_Entered)
	body_exited.connect(_check_Player_Exited)

func _check_Player_Entered(body: Node2D) -> void:
	if body.name == "Player":
		Bus.player_bush_collision_update(self)

func _check_Player_Exited(body: Node2D) -> void:
	if body.name == "Player":
		Bus.player_bush_collision_update(null)
