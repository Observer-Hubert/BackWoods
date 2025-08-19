extends Area2D

@export_range(50.0,250.0) var base_Visibility_Range
@export_range(1.0,100.0) var base_Visibility_Scale

@onready var collider = $PlayerVisibilityCollider

var visibility_Scale: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visibility_Scale = base_Visibility_Scale
	collider.shape.radius = base_Visibility_Range
	body_entered.connect(_check_Observer_Entered)
	body_exited.connect(_check_Observer_Exited)

func _check_Observer_Entered(body: Node2D) -> void:
	if body is Creature:
		body.observingPlayer = true
		body.awarenessDelta = visibility_Scale

func _check_Observer_Exited(body: Node2D) -> void:
	if body is Creature:
		body.observingPlayer = false
