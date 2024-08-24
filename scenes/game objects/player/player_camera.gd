extends Camera2D

@export var weight: int = 4
@export var damping: float = 12.0


func _process(delta: float) -> void:
	lean_camera(delta)


func lean_camera(delta: float) -> void:
	var player_global_position := (ObjectManager.get_player() as Player).global_position
	var global_mouse_position := get_global_mouse_position()
	var target_position := (player_global_position * weight + global_mouse_position) / (weight + 1)
	self.global_position = target_position
