extends Node

signal stamina_updated

func stamina_update(newValue):
	stamina_updated.emit(newValue)
