extends VBoxContainer

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var input_hbox: HBoxContainer = $InputHBox

const qte_arrow_up = preload("res://Scenes/UIScenes/qte_arrow_up.tscn")
const qte_arrow_down = preload("res://Scenes/UIScenes/qte_arrow_down.tscn")
const qte_arrow_left = preload("res://Scenes/UIScenes/qte_arrow_left.tscn")
const qte_arrow_right = preload("res://Scenes/UIScenes/qte_arrow_right.tscn")

var in_qte: bool = false
var currentQTE: Array[String]

func _ready() -> void:
	Bus.qte_generated.connect(_update_Display)
	visible = false

func _update_Display(QTE: Array[String], time: float) -> void:
	visible = true
	in_qte = true
	currentQTE = QTE
	for i in currentQTE:
		var newArrow: TextureRect
		match i:
			"Left":
				newArrow = qte_arrow_left.instantiate()
			"Up":
				newArrow = qte_arrow_up.instantiate()
			"Right":
				newArrow = qte_arrow_right.instantiate()
			"Down":
				newArrow = qte_arrow_down.instantiate()
		input_hbox.add_child(newArrow)
	print("test")
	progress_bar.max_value = time
	progress_bar.value = time

func _input(event: InputEvent) -> void:
	if in_qte:
		if event is InputEventKey:
			if currentQTE.is_empty():
				print("uh oh")
				return
			if event.is_action_pressed("Cancel"):
				_end_QTE(false)
			elif event.is_action_pressed("Up") and currentQTE[0] == "Up":
				_input_Success()
			elif event.is_action_pressed("Down") and currentQTE[0] == "Down":
				_input_Success()
			elif event.is_action_pressed("Left") and currentQTE[0] == "Left":
				_input_Success()
			elif event.is_action_pressed("Right") and currentQTE[0] == "Right":
				_input_Success()
			else:
				progress_bar.value -= 0.1

func _input_Success() -> void:
	print("Success")
	input_hbox.remove_child(input_hbox.get_child(0))
	currentQTE.pop_front()
	if currentQTE.size() == 0:
		_end_QTE(true)

func _end_QTE(success: bool) -> void:
	in_qte = false
	for i in input_hbox.get_children():
		input_hbox.remove_child(i)
	Bus.signal_qte_completed(success)
	if success == false:
		$FailAudio.play()
	else:
		$SuccessAudio.play()
	visible = false

func _process(delta: float) -> void:
	if in_qte != false:
		progress_bar.value -= delta
		if progress_bar.value <= 0.0:
			_end_QTE(false)
