extends CharacterBody2D
class_name Player

@export_category("Player")
@export_group("Movement")
@export var speed: float = 200
@export var friction: float = 0.15
@export var acceleration: float = 0.15

@onready var camera: Camera2D = $Camera2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var weapon: Weapon = $Weapon


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	aim()


func _physics_process(delta: float) -> void:
	movement()


func movement() -> void:
	var movement_direction := get_movement_direction_normalized()
	if movement_direction.length() > 0:
		velocity = velocity.lerp(movement_direction * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func aim() -> void:
	pass


func get_movement_direction_normalized() -> Vector2:
	var movement_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return movement_direction.normalized()


func get_aim_direction_normalized() -> Vector2:
	var global_mouse_position := get_global_mouse_position()
	var aim_direction := Vector2.ZERO
	aim_direction = self.global_position.direction_to(global_mouse_position)
	return aim_direction.normalized()


func squash_sprite(aim_direction: Vector2) -> void:
	var squash_direction := -aim_direction
	
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self.sprite.material, "shader_parameter/squash_direction", squash_direction, 0.05)
	tween.tween_property(self.sprite.material, "shader_parameter/squash_direction", Vector2.ZERO, 0.05).from_current()
