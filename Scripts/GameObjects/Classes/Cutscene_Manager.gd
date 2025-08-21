class_name CutsceneManager extends Node2D

@export var cutscene_Data: Array[CutsceneKeyframe]

var keyframe_Index: int = 0

func _ready() -> void:
	Bus.dialogue_end.connect(_next_Keyframe)
	for child in get_children():
		if child is CutsceneTrigger:
			child.cutscene_triggered.connect(_begin_Cutscene)

func _begin_Cutscene() -> void:
	keyframe_Index = 0
	Bus.start_cutscene()
	Bus.pass_dialogue_event(cutscene_Data[keyframe_Index].dialogue_Data)

func _next_Keyframe() -> void:
	if keyframe_Index < cutscene_Data.size():
		keyframe_Index += 1
	else:
		Bus.end_cutscene()
