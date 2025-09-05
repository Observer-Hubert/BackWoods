extends StaticBody2D

const evergreenSprite: AtlasTexture = preload("res://Assets/Sprites/NatureSprites/Evergreen.tres")
const evergreen2Sprite: AtlasTexture = preload("res://Assets/Sprites/NatureSprites/Evergreen2.tres")
const birchSprite: AtlasTexture = preload("res://Assets/Sprites/NatureSprites/Birch.tres")
const birch2Sprite: AtlasTexture = preload("res://Assets/Sprites/NatureSprites/Birch2.tres")

enum treeType {EVERGREEN, EVERGREEN2, BIRCH, BIRCH2}
@export var tree_Type: treeType
@export_range(0,3,1,"Frame") var tree_Size: int
@export var sprite: Sprite2D

func _ready() -> void:
	match tree_Type:
		treeType.EVERGREEN:
			sprite.texture = evergreenSprite
		treeType.EVERGREEN2:
			sprite.texture = evergreen2Sprite
		treeType.BIRCH:
			sprite.texture = birchSprite
		treeType.BIRCH2:
			sprite.texture = birch2Sprite
	sprite.texture.region.position.x = 64 * tree_Size
