extends EnemyBase
class_name EnemyDummy

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var hide_health_bar_timer: Timer = $HideHealthBarTimer


func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	update_health_bar()


func _process(delta: float) -> void:
	rotation_degrees = lerp_angle(rotation_degrees, rotation_degrees + 1, randf())


func take_damage(damage: float, is_crit: bool = false) -> void:
	health -= damage
	
	if health <= 0:
		destroy()
	
	update_health_bar()
	show_health_bar()
	
	hide_health_bar_timer.start(1.5)


func destroy() -> void:
	self.queue_free()


func perform_effects(entity: EntityBase) -> void:
	var squash_direction := entity.move_direction
	self.sprite.material.set("shader_parameter/flash_value", 1.0)
	
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self.sprite.material, "shader_parameter/squash_direction", squash_direction, 0.05)
	tween.tween_property(self.sprite.material, "shader_parameter/squash_direction", Vector2.ZERO, 0.08).from_current()
	
	tween.finished.connect(func():
		self.sprite.material.set("shader_parameter/flash_value", 0.0)
	)


# show health bar
# if health bar is shown already return
func show_health_bar() -> void:
	if health_bar.visible:
		return
	
	health_bar.visible = true


func update_health_bar() -> void:
	health_bar.value = health


func hide_health_bar() -> void:
	health_bar.visible = false


func _on_hurt_box_area_entered(other_area: EntityBase) -> void:
	if other_area.is_in_group("entity"):
		perform_effects(other_area)
		take_damage(other_area.damage, other_area.is_crit)


func _on_hide_health_bar_timer_timeout() -> void:
	hide_health_bar()
