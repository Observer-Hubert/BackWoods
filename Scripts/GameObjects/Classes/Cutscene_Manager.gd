class_name CutsceneManager extends Node2D

@export var cutscene_Data: Array[CutsceneKeyframe]

var keyframe_Index: int = 0
var in_Cutscene: bool = false
var dialogue_Done: bool = false
var movement_Done: bool = false

func _ready() -> void:
	Bus.dialogue_end.connect(_dialogue_Finished)
	for child in get_children():
		if child is CutsceneTrigger:
			child.cutscene_triggered.connect(_begin_Cutscene)

func _begin_Cutscene() -> void:
	in_Cutscene = true
	keyframe_Index = 0
	_load_Keyframe(keyframe_Index)
	Bus.start_cutscene()

func _load_Keyframe(index: int) -> void:
	dialogue_Done = false
	movement_Done = false
	if cutscene_Data[index].dialogue_Data.size() > 0:
		Bus.pass_dialogue_event(cutscene_Data[keyframe_Index].dialogue_Data)
	else:
		_dialogue_Finished()
	if cutscene_Data[index].subject:
		var tween = get_tree().create_tween()
		tween.tween_property(get_node(cutscene_Data[index].subject), "position", get_node(cutscene_Data[index].subject).position + cutscene_Data[index].subject_Movement, cutscene_Data[index].movement_Time)
		tween.finished.connect(_movement_Finished)
		get_node(cutscene_Data[index].subject).sprite.play(cutscene_Data[index].subject_Animation)
		if cutscene_Data[index].subject_FlipH_When_Moving == true:
			get_node(cutscene_Data[index].subject).sprite.flip_h = true
		else:
			get_node(cutscene_Data[index].subject).sprite.flip_h = false
	else:
		_movement_Finished()

func _dialogue_Finished() -> void:
	dialogue_Done = true
	_next_Keyframe()

func _movement_Finished() -> void:
	movement_Done = true
	if cutscene_Data[keyframe_Index].subject:
		get_node(cutscene_Data[keyframe_Index].subject).sprite.play(cutscene_Data[keyframe_Index].subject_End_Animation)
	_next_Keyframe()

func _next_Keyframe() -> void:
	if dialogue_Done and movement_Done:
		if keyframe_Index < cutscene_Data.size()-1:
			keyframe_Index += 1
			_load_Keyframe(keyframe_Index)
		else:
			in_Cutscene = false
			Bus.end_cutscene()
