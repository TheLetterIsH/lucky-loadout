extends Node


func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")


func get_entity_container() -> Node2D:
	return get_tree().get_first_node_in_group("entity_container")


func get_particle_container() -> Node2D:
	return get_tree().get_first_node_in_group("particle_container")
