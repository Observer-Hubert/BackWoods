extends Animal

@onready var timer = $Timer
@onready var fox_sprite = $FoxSprite

var desiredPos: Vector2

func _ready() -> void:
	timer.start(2.0)
	_change_Behavior()
	timer.timeout.connect(_change_Behavior)

func _change_Behavior() -> void:
	var behavior = randi_range(0,1)
	if behavior == 0:
		fox_sprite.play("Running")
		desiredPos = Vector2(randf_range(-1,1),randf_range(-0.5,0.5))
		if desiredPos.x < 0.0:
			fox_sprite.scale.x = -1
		else:
			fox_sprite.scale.x = 1
	else:
		fox_sprite.play("Standing")
		desiredPos = Vector2.ZERO
	timer.start(2.0)

func _physics_process(_delta: float) -> void:
	move_and_collide(desiredPos)
