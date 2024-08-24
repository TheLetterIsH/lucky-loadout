extends EntityBase
class_name EntityBoomerang

var distance_travelled: float = 0
var is_returning: bool = false
var player: Player = ObjectManager.get_player() as Player

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite.modulate = color
	self.rotate(move_direction.angle())


func _process(delta: float) -> void:
	if can_rotate:
		rotation_degrees = lerp_angle(rotation_degrees, rotation_degrees + 1, rotation_speed)
	
	if is_returning:
		position = position.move_toward(player.position, delta * speed)
	else:
		var position_increment := move_direction * speed * delta
		position += position_increment
	
	distance_travelled += speed * delta
	
	if distance_travelled >= range:
		is_returning = true
	
	if is_returning and position.distance_squared_to(player.position) <= 16:
		destroy()


func perform_effects() -> void:
	var particle_effect_instance := particle_effect_scene.instantiate() as Node2D
	particle_effect_instance.position = self.position
	particle_effect_instance.get_child(0).modulate = color
	ObjectManager.get_particle_container().add_child(particle_effect_instance)


func destroy() -> void:
	self.queue_free()


func _on_area_entered(other_area: Area2D) -> void:
	# no conditions since the only areas this will ever collide with are enemy hurt boxes
	perform_effects()
	
	# TODO chaining, piercing and area of effect


func _on_body_entered(body: Node2D) -> void:
	# no conditions since the only colliders this will ever collide with are environment wall colliders
	is_returning = true
	move_direction = Vector2(move_direction.x, move_direction.y)
	
