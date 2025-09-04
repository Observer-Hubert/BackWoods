extends Interactable

@export var audio_Player: AudioStreamPlayer2D

func interact() -> void:
	audio_Player.play()
