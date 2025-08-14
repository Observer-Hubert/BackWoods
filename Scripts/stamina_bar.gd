extends ProgressBar

func _update_Value(newValue):
	value = newValue

func _ready():
	Bus.stamina_updated.connect(_update_Value)
