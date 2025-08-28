extends TextureRect

var currentFrame: int = 1

func _ready() -> void:
	$Timer.timeout.connect(_next_Frame)

func _next_Frame() -> void:
	if currentFrame < 289:
		var nextFrame = ResourceLoader.load("./Assets/Sprites/Menu/MenuFinalVersion" + str(currentFrame) + ".png")
		texture = nextFrame
		currentFrame += 1
	else:
		var nextFrame = ResourceLoader.load("./Assets/Sprites/Menu/MenuFinalVersion" + str(1) + ".png")
		texture = nextFrame
		currentFrame = 1
