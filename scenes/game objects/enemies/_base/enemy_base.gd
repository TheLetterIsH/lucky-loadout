extends CharacterBody2D
class_name EnemyBase

@export var max_health: float
var health: float


func take_damage(damage: float, is_crit: bool = false) -> void:
	pass


func destroy() -> void:
	pass
