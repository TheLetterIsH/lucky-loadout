extends Resource
class_name WeaponResource

@export_category("Core")
@export var id: int
@export var identifier: String
@export var name: String
@export_multiline var description: String
@export var cost: int
@export var tier: int
@export_enum("sword", "dagger", "bow", "throwable", "wand", "tome") var type: String
@export var color: Color

@export_category("Attributes")
@export var rate: float

@export_group("Primary")
@export_enum("basic", "burst", "pellet", "split", "blurt", "parallel", "away") var pattern: String
@export var entity_scene: PackedScene
@export var number_of_entities: int # Default is 1
@export var spawn_interval: float # Applicable for "burst", default is 0
@export_range(0, 360) var spread: float # Applicable for "pellet", "split" and "away", default is 0
@export_range(0, 15) var accuracy_variation: float
@export var range: float
@export_range(0, 5) var range_variation: float
@export var speed: float
@export var min_damage: float
@export var max_damage: float
@export_range(0, 1) var crit_chance: float
@export var crit_mult: float

@export_subgroup("Special")
@export var can_do_damage_over_time: bool
@export var damage_over_time: float
@export var damage_over_time_lifetime: float

@export var is_piercing: bool

@export var is_chaining: bool
@export var chaining_amount: int

@export var is_homing: bool
@export_range(0, 100) var homing_strength: float

@export_range(0, 1) var spawn_chance: float
@export var spawn_scene: PackedScene
@export_range(0, 4) var spawn_size_mult: float

@export_subgroup("Misc")
@export var can_rotate: bool
@export var rotation_speed: float

@export_group("Secondary")
@export var has_secondary: bool
@export var secondary_interval: int
@export_enum("basic", "burst", "pellet", "split", "blurt", "parallel", "away") var secondary_pattern: String
@export var secondary_entity_scene: PackedScene
@export var secondary_number_of_entities: int # Default is 1
@export var secondary_spawn_interval: float # Applicable for "burst", default is 0
@export_range(0, 360) var secondary_spread: float # Applicable for "pellet", "split" and "away", default is 0
@export_range(0, 15) var secondary_accuracy_variation: float
@export var secondary_range: float
@export_range(0, 5) var secondary_range_variation: float
@export var secondary_speed: float
@export var secondary_min_damage: float
@export var secondary_max_damage: float
@export_range(0, 1) var secondary_crit_chance: float
@export var secondary_crit_mult: float

@export_subgroup("Special")
@export var secondary_can_do_damage_over_time: bool
@export var secondary_damage_over_time: float
@export var secondary_damage_over_time_lifetime: float

@export var secondary_is_piercing: bool

@export var secondary_is_chaining: bool
@export var secondary_chaining_amount: int

@export var secondary_is_homing: bool
@export_range(0, 100) var secondary_homing_strength: float

@export_range(0, 1) var secondary_spawn_chance: float
@export var secondary_spawn_scene: PackedScene
@export_range(0, 4) var secondary_spawn_size_mult: float

@export_subgroup("Misc")
@export var secondary_can_rotate: bool
@export var secondary_rotation_speed: float
