extends Area2D

@onready var collider: CollisionShape2D = $LoudSoundCollider

func _ready() -> void:
	body_entered.connect(_pass_Sound)

func _pass_Sound(body) -> void:
	if body is Creature:
		body.hear_Noise(position)

func make_Noise(radius: float, duration: float = 0.1) -> void:
	collider.shape.radius = radius
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(_reset)

func _reset() -> void:
	collider.shape.radius = 0.01
