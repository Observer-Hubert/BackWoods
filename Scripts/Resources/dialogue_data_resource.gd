extends Resource

class_name DialogueData

@export var texture: Texture
@export var speaker: String
@export var text: String
@export_range(0.01,1.0,0.01) var text_Speed: float = 0.05
@export_range(0.1,2.0,0.1,"Seconds") var text_End_Time = 1.0
