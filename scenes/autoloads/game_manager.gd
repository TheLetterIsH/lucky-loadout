extends Node

@export var new_game_plus: int


func _ready() -> void:
	# if new_game_plus save exists, then use that or use default (0)
	new_game_plus = SaveSystem.get_var("new_game_plus", 0)
