class_name Moped extends Interactable

@export var moped_Dialogue: DialogueData

func interact():
	if moped_Dialogue:
		Bus.pass_dialogue_event([moped_Dialogue])
