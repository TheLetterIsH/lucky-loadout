extends Camera2D

@export var weight: int = 4
@export var damping: float = 6.0


func _process(delta: float) -> void:
	lean_camera(delta)


func lean_camera(delta: float) -> void:
	var player_global_position: Vector2 = (ObjectManager.get_player() as Player).global_position
	var global_mouse_position: Vector2 = get_global_mouse_position()
	var target_position: Vector2 = (player_global_position * weight + global_mouse_position) / (weight + 1)
	self.global_position = self.global_position.lerp(target_position, delta * damping)
