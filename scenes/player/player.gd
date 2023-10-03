extends Area2D


@export var char_stats: CharacterStats : set = set_character_stats
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: HBoxContainer = $StatsUI


func _ready() -> void:
	update_player()
	char_stats.stats_changed.connect(_on_stats_changed)


func set_character_stats(value: CharacterStats) -> void:
	char_stats = value.create_instance()
	update_player()


func update_player() -> void:
	if not is_inside_tree(): 
		return
	if not char_stats is CharacterStats: 
		return
	sprite_2d.texture = char_stats.art
	update_stats()


func take_damage(damage: int) -> void:
	char_stats.take_damage(damage)
	if char_stats.health <= 0:
		queue_free()


func update_stats() -> void:
	stats_ui.update_stats(char_stats)


func _on_stats_changed() -> void:
	update_stats()
