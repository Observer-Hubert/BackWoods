class_name POISearchArea extends Area2D

@onready var collider: CollisionShape2D = $POISearchCollider

func search_Hiding_Places(flag: int) -> Node2D:
	for body in get_overlapping_bodies():
		if body is HidingPlace:
			if (body.valid_Hiders & (1 << flag) != 0):
				return body
	return self

func search_Forage_Places(flag: int) -> Node2D:
	for body in get_overlapping_bodies():
		if body is ForageZone:
			if (body.valid_Hiders & (1 << flag) != 0):
				return body
	return self
