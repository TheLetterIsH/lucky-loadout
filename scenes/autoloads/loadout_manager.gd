extends Node

@export var current_loadout: Array[Resource]
@export var current_loadout_paths: Array[String]


func _ready() -> void:
	# if current loadout_paths save exists, then use that; by default the current loadout paths contain default weapon path
	# then make the current loadout array from the current loadout paths
	pass


func is_loudout_full() -> bool:
	if current_loadout.size() >= 6:
		return true
	
	return false


func get_random_weapon_from_loadout() -> Resource:
	if current_loadout.size() == 0:
		return
	
	var weapon := current_loadout.pick_random() as WeaponResource
	return weapon
