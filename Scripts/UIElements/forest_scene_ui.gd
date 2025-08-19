extends Control

var readout_Scene: PackedScene = load("res://Scenes/UIScenes/photo_readout.tscn")
var current_Readout: Control = null

func _ready() -> void:
	Bus.valid_photo_taken.connect(_create_Readout)

# Creates a photo readout based on any valid photo data sent through the valid_photo_taken signal.
func _create_Readout(photo_Data: PhotoData) -> void:
	# If there is already a readout, we do not need to delete it outright, rather, we tell it to begin falling to make room for the new readout.
	if current_Readout != null:
		current_Readout.anim_player.play("Fall")
	current_Readout = readout_Scene.instantiate()
	current_Readout.photo_Data = photo_Data
	add_child(current_Readout)
