extends HSlider

@export var busIndex: int = 0

func _ready() -> void:
	value_changed.connect(_update_Audio)

func _update_Audio(newValue: float)-> void:
	AudioServer.set_bus_volume_linear(busIndex,newValue)

func _process(_delta: float) -> void:
	value = AudioServer.get_bus_volume_linear(busIndex)
