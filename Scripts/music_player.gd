extends AudioStreamPlayer

const CREDITS = preload("res://Assets/Sounds/Songs/Credits.wav")
const LOVELY_FOREST = preload("res://Assets/Sounds/Songs/Lovely_Forest.wav")
const MAIN_MENU_SIMPLE = preload("res://Assets/Sounds/Songs/Main_Menu_Simple.wav")
const SPOOKY_FOREST = preload("res://Assets/Sounds/Songs/Spooky_Forest.wav")
const THAT_S_NO_DEER = preload("res://Assets/Sounds/Songs/That's_No_Deer.wav")

func _ready() -> void:
	_play_Track(MAIN_MENU_SIMPLE)
	Bus.change_scene.connect(_scene_Music_Update)
	Bus.go_home.connect(_play_Track.bind(MAIN_MENU_SIMPLE))

func _play_Track(track: AudioStreamWAV) -> void:
	stream = track
	play()

func _scene_Music_Update(sceneName: String) -> void:
	match sceneName:
		"screen3":
			_play_Track(SPOOKY_FOREST)
		"screen1":
			_play_Track(LOVELY_FOREST)
