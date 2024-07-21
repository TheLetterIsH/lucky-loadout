extends Area2D
class_name EntityBase

@export var death_effect_scene: PackedScene


# base
var move_direction: Vector2
var range: float
var speed: float
var damage: float
var is_crit: bool

# specials
var can_do_damage_over_time: bool
var damage_over_time: float
var damage_over_time_lifetime: float

var is_piercing: bool

var is_chaining: bool
var chaining_amount: int

var is_homing: bool
var homing_strength: float

var can_spawn: bool
var spawn_chance: float
var spawn_scene: PackedScene
var spawn_size_mult: float

# misc
var color: Color
var can_rotate: bool
var rotation_speed: float


func destroy() -> void:
	pass
