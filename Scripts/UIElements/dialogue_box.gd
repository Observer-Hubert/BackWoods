extends Control

@onready var text_label = $DialogueBoxMargin/DialogueBoxPanel/HBoxContainer/VBoxContainer/TextMargin/TextLabel
@onready var speaker_label = $DialogueBoxMargin/DialogueBoxPanel/HBoxContainer/VBoxContainer/SpeakerLabel
@onready var speaker_texture = $DialogueBoxMargin/DialogueBoxPanel/HBoxContainer/SpeakerTexture
@onready var char_timer = $CharTimer
@onready var next_timer = $NextTimer

var dialogue_Data: Array[DialogueData]
var dialogue_Index: int = 0

func _ready() -> void:
	char_timer.timeout.connect(_next_Char)
	next_timer.timeout.connect(_next_Dialogue)
	Bus.dialogue_event.connect(_update_Dialogue)
	Bus.dialogue_skip.connect(_skip_Dialogue)

func _update_Dialogue(newDialogue: Array[DialogueData]) -> void:
	dialogue_Data = newDialogue
	dialogue_Index = 0
	visible = true
	_display_Dialogue(dialogue_Index)

func _display_Dialogue(index: int) -> void:
	next_timer.stop()
	text_label.text = ""
	if dialogue_Data[index].speaker != "":
		speaker_label.text = dialogue_Data[index].speaker
	if dialogue_Data[index].texture != null:
		speaker_texture.texture = dialogue_Data[index].texture
	char_timer.start(dialogue_Data[index].text_Speed)

func _skip_Dialogue():
	if text_label.text.length() != dialogue_Data[dialogue_Index].text.length():
		text_label.text = dialogue_Data[dialogue_Index].text
		next_timer.start(dialogue_Data[dialogue_Index].text_End_Time)
	else:
		_next_Dialogue()

func _next_Char() -> void:
	if text_label.text.length() < dialogue_Data[dialogue_Index].text.length():
		text_label.text = dialogue_Data[dialogue_Index].text.left(text_label.text.length() + 1)
		if text_label.text.length() >= dialogue_Data[dialogue_Index].text.length():
			next_timer.start(dialogue_Data[dialogue_Index].text_End_Time)

func _next_Dialogue():
	if dialogue_Index < dialogue_Data.size() - 1:
		dialogue_Index += 1
		_display_Dialogue(dialogue_Index)
	else:
		speaker_label.text = ""
		speaker_texture.texture = null
		text_label.text = ""
		Bus.end_dialogue()
		visible = false
