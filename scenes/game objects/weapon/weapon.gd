extends Node2D
class_name Weapon

@export_category("Weapon")
@export var current_weapon: WeaponResource
@export var can_use_attack: bool
@export var attack_count: int

var player: Player

@onready var rate_timer: Timer = $RateTimer
@onready var switch_timer: Timer = $SwitchTimer


func _ready() -> void:
	# get all variables
	player = ObjectManager.get_player()
	
	#current_weapon = preload("res://resources/weapons/00_wooden_stick.tres")
	current_weapon = LoadoutManager.get_random_weapon_from_loadout()
	initialize_weapon()


func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		if can_use_attack:
			attack()
			
			can_use_attack = false
			rate_timer.start()


func attack() -> void:
	attack_count += 1
	
	if current_weapon.has_secondary and attack_count >= current_weapon.secondary_interval:
		spawn_entity("secondary")
		attack_count = 0
		return
	
	spawn_entity("primary")


func spawn_entity(entity_type: String) -> void:
	if entity_type == "primary":
		match current_weapon.pattern:
			# primary basic
			"basic":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				
				for i in range(current_weapon.number_of_entities):
					# instantiate entity + set attributes
					var entity_instance := current_weapon.entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# primary burst
			"burst":
				var aim_direction := player.get_aim_direction_normalized()
				
				for i in range(current_weapon.number_of_entities):
					var spawn_position := player.global_position
					# instantiate entity + set attributes
					var entity_instance := current_weapon.entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
					
					# spawn entity game juice
					perform_effects(aim_direction)
					
					await get_tree().create_timer(current_weapon.spawn_interval).timeout
			
			# primary pellet
			"pellet":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				var spread_in_radians := deg_to_rad(current_weapon.spread)
				
				for i in range(current_weapon.number_of_entities):
					var random_angle := randf_range(-spread_in_radians / 2, spread_in_radians / 2)
					var individual_aim_direction := aim_direction.rotated(random_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, individual_aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# primary split
			"split":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				var spread_in_radians := deg_to_rad(current_weapon.spread)
				var angle_increment := spread_in_radians / (current_weapon.number_of_entities - 1)
				
				if current_weapon.spread == 360:
					angle_increment = spread_in_radians / current_weapon.number_of_entities
				
				for i in range(current_weapon.number_of_entities):
					var current_angle := (-spread_in_radians / 2) + (i * angle_increment)
					aim_direction = player.get_aim_direction_normalized()
					aim_direction = aim_direction.rotated(current_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# primary blurt
			"blurt":
				var spread_in_radians = deg_to_rad(current_weapon.spread)
				
				for i in range(current_weapon.number_of_entities):
					var spawn_position := player.global_position
					var aim_direction := player.get_aim_direction_normalized()
					var random_angle := randf_range(-spread_in_radians / 2, spread_in_radians / 2)
					aim_direction = aim_direction.rotated(random_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
					
					# spawn entity game juice
					perform_effects(aim_direction)
					
					await get_tree().create_timer(current_weapon.spawn_interval).timeout
			
			# primary parallel
			"parallel":
				var spawn_position_1 := player.global_position - Vector2(0, 6.5)
				var spawn_position_2 := player.global_position + Vector2(0, 6.5)
				var aim_direction := player.get_aim_direction_normalized()
				var angle := aim_direction.angle()
				
				spawn_position_1 = player.global_position + (spawn_position_1 - player.global_position).rotated(angle)
				spawn_position_2 = player.global_position + (spawn_position_2 - player.global_position).rotated(angle)
				
				# instantiate entity + set attributes
				var entity_instance_1 := current_weapon.entity_scene.instantiate() as EntityBase
				set_entity_attributes(entity_type, entity_instance_1, spawn_position_1, aim_direction)
				ObjectManager.get_entity_container().add_child(entity_instance_1)
				
				# instantiate entity + set attributes
				var entity_instance_2 := current_weapon.entity_scene.instantiate() as EntityBase
				set_entity_attributes(entity_type, entity_instance_2, spawn_position_2, aim_direction)
				ObjectManager.get_entity_container().add_child(entity_instance_2)
				
				# spawn entity game juice
				perform_effects(aim_direction)
	
	if entity_type == "secondary":
		match current_weapon.secondary_pattern:
			# secondary basic
			"basic":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				
				for i in range(current_weapon.secondary_number_of_entities):
					# instantiate entity + set attributes
					var entity_instance := current_weapon.secondary_entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# secondary burst
			"burst":
				var aim_direction := player.get_aim_direction_normalized()
				
				for i in range(current_weapon.secondary_number_of_entities):
					var spawn_position := player.global_position
					# instantiate entity + set attributes
					var entity_instance := current_weapon.secondary_entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
					
					# spawn entity game juice
					perform_effects(aim_direction)
					
					await get_tree().create_timer(current_weapon.secondary_spawn_interval).timeout
			
			# secondary pellet
			"pellet":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				var spread_in_radians := deg_to_rad(current_weapon.secondary_spread)
				
				for i in range(current_weapon.secondary_number_of_entities):
					var random_angle := randf_range(-spread_in_radians / 2, spread_in_radians / 2)
					var individual_aim_direction := aim_direction.rotated(random_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.secondary_entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, individual_aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# Ssecondary split
			"split":
				var spawn_position := player.global_position
				var aim_direction := player.get_aim_direction_normalized()
				var spread_in_radians := deg_to_rad(current_weapon.secondary_spread)
				var angle_increment := spread_in_radians / (current_weapon.secondary_number_of_entities - 1)
				
				if current_weapon.secondary_spread == 360:
					angle_increment = spread_in_radians / current_weapon.secondary_number_of_entities
				
				for i in range(current_weapon.secondary_number_of_entities):
					var current_angle := (-spread_in_radians / 2) + (i * angle_increment)
					aim_direction = player.get_aim_direction_normalized()
					aim_direction = aim_direction.rotated(current_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.secondary_entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
				
				# spawn entity game juice
				perform_effects(aim_direction)
			
			# secondary blurt
			"blurt":
				var spread_in_radians = deg_to_rad(current_weapon.secondary_spread)
				
				for i in range(current_weapon.secondary_number_of_entities):
					var spawn_position := player.global_position
					var aim_direction := player.get_aim_direction_normalized()
					var random_angle := randf_range(-spread_in_radians / 2, spread_in_radians / 2)
					aim_direction = aim_direction.rotated(random_angle)
					# instantiate entity + set attributes
					var entity_instance := current_weapon.secondary_entity_scene.instantiate() as EntityBase
					set_entity_attributes(entity_type, entity_instance, spawn_position, aim_direction)
					ObjectManager.get_entity_container().add_child(entity_instance)
					
					# spawn entity game juice
					perform_effects(aim_direction)
					
					await get_tree().create_timer(current_weapon.secondary_spawn_interval).timeout
			
			# secondary parallel
			"parallel":
				var spawn_position_1 := player.global_position - Vector2(0, 6.5)
				var spawn_position_2 := player.global_position + Vector2(0, 6.5)
				var aim_direction := player.get_aim_direction_normalized()
				var angle := aim_direction.angle()
				
				spawn_position_1 = player.global_position + (spawn_position_1 - player.global_position).rotated(angle)
				spawn_position_2 = player.global_position + (spawn_position_2 - player.global_position).rotated(angle)
				
				# instantiate entity + set attributes
				var entity_instance_1 := current_weapon.secondary_entity_scene.instantiate() as EntityBase
				set_entity_attributes(entity_type, entity_instance_1, spawn_position_1, aim_direction)
				ObjectManager.get_entity_container().add_child(entity_instance_1)
				
				# instantiate entity + set attributes
				var entity_instance_2 := current_weapon.secondary_entity_scene.instantiate() as EntityBase
				set_entity_attributes(entity_type, entity_instance_2, spawn_position_2, aim_direction)
				ObjectManager.get_entity_container().add_child(entity_instance_2)
				
				# spawn entity game juice
				perform_effects(aim_direction)


func set_entity_attributes(entity_type: String, entity_instance: EntityBase, spawn_position: Vector2, aim_direction: Vector2) -> void:
	entity_instance.color = current_weapon.color
	entity_instance.position = spawn_position
	
	# for primary entity types
	if entity_type == "primary":
		# base
		# calculate move direction
		var accuracy_variation_in_radians := deg_to_rad(current_weapon.accuracy_variation)
		var random_accuracy_variation := randf_range(-accuracy_variation_in_radians / 2, accuracy_variation_in_radians / 2)
		var move_direction := aim_direction.rotated(random_accuracy_variation)
		 # assign move direction
		entity_instance.move_direction = move_direction
		
		# calculate range
		var range := current_weapon.range + randf_range(-current_weapon.range_variation, current_weapon.range_variation)
		range *= 32 # multiply range by tile unit size (32)
		# assign range
		entity_instance.range = range # TODO add mults
		
		# calculate speed
		var speed := current_weapon.speed * 100
		# assign speed
		entity_instance.speed = speed # TODO add mults
		
		# calculate damage
		var damage := randf_range(current_weapon.min_damage, current_weapon.max_damage)
		# assign damage
		entity_instance.damage = damage # TODO add mults
		
		# calculate crit
		var crit_chance := current_weapon.crit_chance # TODO add mults
		var random_crit_chance := randf_range(0, 1)
		# assign crit
		if random_crit_chance <= crit_chance:
			entity_instance.is_crit = true
			var crit_mult := current_weapon.crit_mult # TODO add mults
			entity_instance.damage *= crit_mult
		
		# specials
		# assign damage over time
		entity_instance.can_do_damage_over_time = current_weapon.can_do_damage_over_time
		entity_instance.damage_over_time = current_weapon.damage_over_time # TODO add mults
		entity_instance.damage_over_time_lifetime = current_weapon.damage_over_time_lifetime # TODO add mults
		
		# assign piercing
		entity_instance.is_piercing = current_weapon.is_piercing
		
		# assign chaining
		entity_instance.is_chaining = current_weapon.is_chaining
		entity_instance.chaining_amount = current_weapon.chaining_amount # TODO add mults
		
		# assign homing
		entity_instance.is_homing = current_weapon.is_homing
		entity_instance.homing_strength = current_weapon.homing_strength # TODO add mults
		
		# calculate spawn
		var spawn_chance := current_weapon.spawn_chance # TODO add mults
		var random_spawn_chance := randf_range(0, 1)
		# assign spawn
		if random_spawn_chance <= spawn_chance:
			entity_instance.can_spawn = true
			entity_instance.spawn_scene = current_weapon.spawn_scene
			var spawn_size_mult := current_weapon.spawn_size_mult # TODO add mults
			entity_instance.spawn_size_mult *= spawn_size_mult
		
		# misc
		entity_instance.can_rotate = current_weapon.can_rotate
		entity_instance.rotation_speed = current_weapon.rotation_speed
	
	# for secondary entity types
	if entity_type == "secondary":
		# base
		# calculate move direction
		var accuracy_variation_in_radians := deg_to_rad(current_weapon.secondary_accuracy_variation)
		var random_accuracy_variation := randf_range(-accuracy_variation_in_radians / 2, accuracy_variation_in_radians / 2)
		var move_direction := aim_direction.rotated(random_accuracy_variation)
		 # assign move direction
		entity_instance.move_direction = move_direction
		
		# calculate range
		var range := current_weapon.secondary_range + randf_range(-current_weapon.secondary_range_variation, current_weapon.secondary_range_variation)
		range *= 32 # multiply range by tile unit size (32)
		# assign range
		entity_instance.range = range # TODO add mults
		
		# calculate speed
		var speed := current_weapon.secondary_speed * 100
		# assign speed
		entity_instance.speed = speed # TODO add mults
		
		# calculate damage
		var damage := randf_range(current_weapon.secondary_min_damage, current_weapon.secondary_max_damage)
		# assign damage
		entity_instance.damage = damage # TODO add mults
		
		# calculate crit
		var crit_chance := current_weapon.secondary_crit_chance # TODO add mults
		var random_crit_chance := randf_range(0, 1)
		# assign crit
		if random_crit_chance <= crit_chance:
			entity_instance.is_crit = true
			var crit_mult := current_weapon.secondary_crit_mult # TODO add mults
			entity_instance.damage *= crit_mult
		
		# specials
		# assign damage over time
		entity_instance.can_do_damage_over_time = current_weapon.secondary_can_do_damage_over_time
		entity_instance.damage_over_time = current_weapon.secondary_damage_over_time # TODO add mults
		entity_instance.damage_over_time_lifetime = current_weapon.secondary_damage_over_time_lifetime # TODO add mults
		
		# assign piercing
		entity_instance.is_piercing = current_weapon.secondary_is_piercing
		
		# assign chaining
		entity_instance.is_chaining = current_weapon.secondary_is_chaining
		entity_instance.chaining_amount = current_weapon.secondary_chaining_amount # TODO add mults
		
		# assign homing
		entity_instance.is_homing = current_weapon.secondary_is_homing
		entity_instance.homing_strength = current_weapon.secondary_homing_strength # TODO add mults
		
		# calculate spawn
		var spawn_chance := current_weapon.secondary_spawn_chance # TODO add mults
		var random_spawn_chance := randf_range(0, 1)
		# assign spawn
		if random_spawn_chance <= spawn_chance:
			entity_instance.can_spawn = true
			entity_instance.spawn_scene = current_weapon.secondary_spawn_scene
			var spawn_size_mult := current_weapon.secondary_spawn_size_mult # TODO add mults
			entity_instance.spawn_size_mult *= spawn_size_mult
		
		# misc
		entity_instance.can_rotate = current_weapon.secondary_can_rotate
		entity_instance.rotation_speed = current_weapon.secondary_rotation_speed


func perform_effects(aim_direction: Vector2) -> void:
	player.squash_sprite(aim_direction)


func initialize_weapon() -> void:
	attack_count = 0
	
	if current_weapon.rate == 0:
		return
	
	rate_timer.wait_time = 1 / current_weapon.rate


func switch_weapon() -> void:
	var previous_weapon := current_weapon
	current_weapon = LoadoutManager.get_random_weapon_from_loadout()
	initialize_weapon()
	GameEvents.fire_weapon_switched() # TODO pass parameters


func _on_rate_timer_timeout() -> void:
	can_use_attack = true


func _on_switch_timer_timeout() -> void:
	switch_weapon()
