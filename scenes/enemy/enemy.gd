class_name Enemy
extends Area2D


@export var stats: Stats : set = set_enemy_stats
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: HBoxContainer = $StatsUI


func _ready() -> void:
	update_enemy()
	stats.stats_changed.connect(_on_stats_changed)


func set_enemy_stats(value: Stats) -> void:
	stats = value.create_instance()
	update_enemy()


func update_enemy() -> void:
	if not is_inside_tree(): 
		return
	if not stats is Stats: 
		return
	sprite_2d.texture = stats.art
	update_stats()


func take_damage(damage: int) -> void:
	stats.take_damage(damage)
	if stats.health <= 0:
		queue_free()


func update_stats() -> void:
	stats_ui.update_stats(stats)


func _on_stats_changed() -> void:
	update_stats()
