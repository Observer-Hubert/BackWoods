##An area that triggers a signal when the player enters its space. Should be a child of a CutsceneManager
class_name CutsceneTrigger extends Area2D

signal cutscene_triggered

func _ready() -> void:
	body_entered.connect(_check_Trigger)

func _check_Trigger(body: Node2D) -> void:
	if body is Player:
		cutscene_triggered.emit()
		set_deferred("monitoring", false)
