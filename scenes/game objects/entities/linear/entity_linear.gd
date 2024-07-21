extends EntityBase
class_name EntityLinear

var distance_travelled: float = 0

@onready var outer_sprite_2d: Sprite2D = $OuterSprite2D
@onready var inner_sprite_2d: Sprite2D = $InnerSprite2D


func _ready() -> void:
	inner_sprite_2d.modulate = Color("#262626")
	outer_sprite_2d.modulate = color
	self.rotate(move_direction.angle())


func _process(delta: float) -> void:
	distance_travelled += speed * delta
	
	var position_increment = move_direction * speed * delta
	position += position_increment
	
	if distance_travelled >= range:
		destroy()


func destroy() -> void:
	var death_effect_instance = death_effect_scene.instantiate() as GPUParticles2D
	death_effect_instance.position = self.position
	death_effect_instance.modulate = color
	death_effect_instance.emitting = true
	ObjectManager.get_particle_container().add_child(death_effect_instance)
	
	self.queue_free()
