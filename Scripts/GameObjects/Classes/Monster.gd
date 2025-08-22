extends Creature

@onready var sprite: AnimatedSprite2D = $CreatureSprite

func _ready() -> void:
	awareness_display = $AwarenessDisplay

func _process(delta: float) -> void:
	if observingPlayer == true:
		_change_Awareness(awarenessDelta * delta)
	if observingPlayer == false:
		_change_Awareness(-awareness_Decay_Rate)
