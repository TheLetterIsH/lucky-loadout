extends EntityBase
class_name EntityWave

var distance_travelled: float = 0
var time: float = 0
var amplitude: float = 0.75
var frequency: float = 10.0

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	self.rotate(move_direction.angle())
	sprite.modulate = color


func _process(delta: float) -> void:
	if can_rotate:
		rotation_degrees = lerp_angle(rotation_degrees, rotation_degrees + 1, rotation_speed)
	
	time += delta
	
	var position_increment := move_direction * speed * delta
	var wave_offset := cos(frequency * time) * amplitude
	position += position_increment + Vector2(move_direction.y, -move_direction.x) * wave_offset
	
	distance_travelled += speed * delta
	
	if distance_travelled >= range:
		perform_effects()
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
	
	# if it has no specials, destroy
	destroy()


func _on_body_entered(other_body: Node2D) -> void:
	# no conditions since the only colliders this will ever collide with are environment wall colliders
	perform_effects()
	destroy()
