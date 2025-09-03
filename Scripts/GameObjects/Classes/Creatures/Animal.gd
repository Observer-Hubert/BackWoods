class_name Animal extends Creature

@export_group("Behavior")
##Determines how often the animal considers new behavior.
@export_range(0.01,10.0) var behavior_Interval: float = 0.5
@export var curious: bool = false
@export var behavior_Origin: Vector2
@export_range(50.0, 1000.0, 10.0) var max_Dist_From_Origin = 250.0
@export var poi_Flag: AnimalInteractable.animals
@export var poi_search_area: POISearchArea
@export var behavior_timer: Timer

@export_group("Movement Speed Mods")
@export var wander_mod: float = 0.5
@export var flee_mod: float = 1.2

enum animalStates{IDLE, FORAGING, INVESTIGATING, FLEEING}

var currentState: animalStates = animalStates.IDLE
var desiredPOI: Node2D

func hear_Noise(noisePos: Vector2) -> void:
	super(noisePos)
	if curious == true:
		change_State(animalStates.INVESTIGATING)
	else:
		change_State(animalStates.FLEEING)

# Takes one of the states and calls the corresponding setup function.
func change_State(newState: animalStates) -> void:
	match newState:
		animalStates.IDLE:
			_idle_State_Setup()
		animalStates.FORAGING:
			_foraging_State_Setup()
		animalStates.INVESTIGATING:
			_investigating_State_Setup()
		animalStates.FLEEING:
			_fleeing_State_Setup()
	currentState = newState

func _physics_process(delta: float) -> void:
	_update_Agent()
	_check_Flip()
	if reachedPos == false:
		move_and_collide(velocity * delta)
	if not observingPlayer:
		change_Awareness(-awareness_Decay_Rate * delta)

func _target_Reached() -> void:
	super()
	if desiredPOI is HidingPlace and currentState == animalStates.FLEEING:
		desiredPOI.Hide()
		queue_free()
	#elif currentState == animalStates.IDLE:
	sprite.play("Standing")

func _forage_Scan() -> bool:
	var nearest_Forage = poi_search_area.search_Forage_Places(poi_Flag as HidingPlace.animals)
	if nearest_Forage is ForageZone:
		desiredPos = nearest_Forage.position
		desiredPOI = nearest_Forage
		return true
	else:
		return false

func _hide_Scan() -> bool:
	var nearest_Hide = poi_search_area.search_Hiding_Places(poi_Flag as HidingPlace.animals)
	if nearest_Hide is HidingPlace:
		desiredPos = nearest_Hide.hide_Entry_Point
		desiredPOI = nearest_Hide
		return true
	else:
		return false

func _wander() -> void:
	var randX = randf_range(-max_Dist_From_Origin,max_Dist_From_Origin) + behavior_Origin.x
	var randY = randf_range(-max_Dist_From_Origin,max_Dist_From_Origin) + behavior_Origin.y	
	desiredPos = Vector2(randX, randY)
	moveSpeed = base_Move_Speed * wander_mod
	sprite.play("Moving")

func _renew_State() -> void:
	reachedPos = false
	match currentState:
		animalStates.IDLE:
			_wander()
		animalStates.FLEEING:
			if not _hide_Scan():
				if lastNoisePos.x < to_global(position).x:
					desiredPos = position + Vector2(1000.0, 0.0)
				else:
					desiredPos = position - Vector2(1000.0, 0.0)

#These will be overwritten by inheriting classes, and provide functionality to the states, being called on a corresponding state change.
func _idle_State_Setup() -> void:
	pass

func _foraging_State_Setup() -> void:
	pass

func _investigating_State_Setup() -> void:
	pass

func _fleeing_State_Setup() -> void:
	pass
