extends Control

@onready var main_2d = $Main_2D
@onready var main_ui = $Main_UI
@onready var main_menu = $Main_UI/Main_Menu

var currentScene: Node2D = null
var currentUI: Control = null

func _ready() -> void:
<<<<<<< HEAD
=======
	main_menu.find_child("Button").pressed.connect(_load_Scene)
>>>>>>> parent of a7e235a (Added um animal moves around)
	Bus.go_home.connect(_go_Home)
	Bus.quit.connect(_quit_Game)
	Bus.change_scene.connect(_load_Scene)

func _go_Home() -> void:
		get_tree().paused = false
		_unload_Scene()

func _quit_Game() -> void:
		get_tree().quit()

func _load_Scene(sceneName: String = "forest_scene", uiName: String = "forest_scene_ui") -> void:
	# Loads a scene from the specified file in the Scenes folder, and places it in the main_2d node.
	var loadedScene: PackedScene = load("res://Scenes/GameScenes/" + sceneName + ".tscn")
	currentScene = loadedScene.instantiate()
	main_2d.add_child(currentScene)
	# Loads a UI scene in the same fashion as the previous scene, placing it in the main_ui node.
	var loadedUI: PackedScene = load("res://Scenes/UIScenes/" + uiName + ".tscn")
	currentUI = loadedUI.instantiate()
	main_ui.add_child(currentUI)
	# If we have an actual UI, we no longer need the main menu.
	main_menu.visible = false
	Input.set_custom_mouse_cursor(null)

# Unloads a scene/ui if there is one present, otherwise returns false.
func _unload_Scene() -> bool:
	if currentScene != null and currentUI != null:
		Input.set_custom_mouse_cursor(load("res://Assets/Sprites/Redticle.png"), Input.CURSOR_ARROW, Vector2(43.0,43.0))
		currentScene.queue_free()
		currentUI.queue_free()
		# Once the scene is unloaded, we will need the main menu.
		main_menu.visible = true
		return true
	else:
		return false
