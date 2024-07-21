extends Node

@export var current_loadout: Array[Resource]
@export var current_loadout_paths: Array[String]
@export var default_weapon: Resource


func _ready() -> void:
	# if current_loadout save exists, then use that or use default (wooden_stick)
	pass


func is_loudout_full() -> bool:
	if current_loadout.size() >= 6:
		return true
	
	return false


func get_random_weapon_from_loadout() -> Resource:
	if current_loadout.size() == 0:
		return
	
	var weapon = current_loadout.pick_random()
	return weapon
