extends Area2D

@export_range(25.0, 250.0, 0.5) var base_Visibility_Range: float
@export_range(1.0, 100.0, 0.1) var base_Visibility_Scale: float

@onready var collider = $PlayerVisibilityCollider

var visibility_Scale: float

func change_Visibility(radiusMult: float = 1.0, scaleMult: float = 1.0) -> void:
	collider.shape.radius = base_Visibility_Range * radiusMult
	visibility_Scale = base_Visibility_Scale * scaleMult

func _ready() -> void:
	change_Visibility()
	body_entered.connect(_check_Observer_Entered)
	body_exited.connect(_check_Observer_Exited)

func _check_Observer_Entered(body: Node2D) -> void:
	if body is Creature:
		body.observingPlayer = true

func _check_Observer_Exited(body: Node2D) -> void:
	if body is Creature:
		body.observingPlayer = false

func _process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is Creature:
			body.change_Awareness(visibility_Scale * delta)
