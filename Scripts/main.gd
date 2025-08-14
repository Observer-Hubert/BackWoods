extends Control

@onready var main_2d = $Main_2D
@onready var main_ui = $Main_UI
@onready var main_menu = $Main_UI/Main_Menu

var currentScene: Node2D = null
var currentUI: Control = null

func _ready():
	main_menu.find_child("Button").pressed.connect(_loadScene)

func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		#attempt to unload scene and ui, if none is present, quit the game
		if not _unloadScene():
			get_tree().quit()

func _loadScene(scene = "forest_scene", ui = "forest_scene_ui"):
	#loads a scene from the specified file in the Scenes folder, and places it in the main_2d node
	var loadedScene: PackedScene = load("res://Scenes/" + scene + ".tscn")
	currentScene = loadedScene.instantiate()
	main_2d.add_child(currentScene)
	#loads a ui scene in the same fashion as the previous scene, placing it in the main_ui node
	var loadedUI: PackedScene = load("res://Scenes/" + ui + ".tscn")
	currentUI = loadedUI.instantiate()
	main_ui.add_child(currentUI)
	main_menu.visible = false

#unloads a scene/ui if there is one present, otherwise returns false
func _unloadScene() -> bool:
	if currentScene != null and currentUI != null:
		currentScene.queue_free()
		currentUI.queue_free()
		main_menu.visible = true
		return true
	else:
		return false
