extends CharacterBody2D
class_name Player

@export_category("Player")
@export_group("Movement")
@export var speed: float = 250
@export var friction: float = 0.15
@export var acceleration: float = 0.15


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	aim()


func _physics_process(delta: float) -> void:
	movement()


func movement() -> void:
	var movement_direction: Vector2 = get_movement_direction_normalized()
	if movement_direction.length() > 0:
		velocity = velocity.lerp(movement_direction * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func aim() -> void:
	pass


func get_movement_direction_normalized() -> Vector2:
	var movement_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return movement_direction.normalized()


func get_aim_direction_normalized() -> Vector2:
	var global_mouse_position: Vector2 = get_global_mouse_position()
	var aim_direction: Vector2 = Vector2.ZERO
	aim_direction = self.global_position.direction_to(global_mouse_position)
	return aim_direction.normalized()
