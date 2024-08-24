extends Node

@export var new_game_plus: int
@export var max_rounds: int
@export var current_round: int
@export var current_phase: int


func _ready() -> void:
	# if new game plus save exists, then use that or use default (0)
	new_game_plus = SaveSystem.get_var("new_game_plus", 0)
	# if current round save exists, then use that or default (1)
	current_round = SaveSystem.get_var("current_round", 1)
	
	calculate_parameters()


func calculate_parameters() -> void:
	# max rounds in this run
	max_rounds = (5 + new_game_plus) * 3
	# current phase value, dependant upon the current round
	current_phase = ceil(current_round / (5 + new_game_plus))


func increment_current_round() -> void:
	pass


# TODO make function that changes the current new game plus value, clears all saves and reinits the run
