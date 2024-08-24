extends Node2D
class_name WaveManager

@export var max_waves: int
@export var current_wave: int


func _ready() -> void:
	max_waves = 3 + (GameManager.current_phase + 1)
	current_wave = 1
	
	# TODO 3 2 1 FIGHT! announcement
	# wait for 1 second
	# clear the announcement
	# enable HUD
	
	spawn_wave() # TODO spawn a wave of enemies


func spawn_wave() -> void:
	# TODO get a random number of enemies to spawn in this wave (2-6)
	# select a random point on the spawnable game arena
	# run a loop (n times) to select n points in random directions from this point
	pass


func increment_current_wave() -> void:
	# TODO if current wave is greater than the maximum number of waves then round won / arena cleared
	# TODO add the following to a round won / arena cleared function
	# ARENA CLEARED! announcement
	# wait for 1 second
	# gold earned this round card pop up
	pass


# TODO on enemy death, check if the enemy container is empty
# if so then increment the current wave value
