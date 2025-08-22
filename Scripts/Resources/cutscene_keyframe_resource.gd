class_name CutsceneKeyframe extends Resource

@export var dialogue_Data: Array[DialogueData]
@export var subject: NodePath
@export var subject_Animation: String
@export var subject_End_Animation: String
@export var subject_FlipH_When_Moving: bool
@export var subject_Movement: Vector2
@export_range(0.1,5.0,0.1,"Seconds") var movement_Time: float = 1.0
@export var movement_Transition_Type: Tween.TransitionType
@export var movement_easing_Mode: Tween.EaseType
