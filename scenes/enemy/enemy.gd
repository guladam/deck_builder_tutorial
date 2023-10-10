class_name Enemy
extends Area2D

@export var stats: EnemyStats : set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI
@onready var arrow: Sprite2D = $Arrow

var enemy_action_picker: EnemyActionPicker


func do_turn() -> void:
	stats.block = 0
	
	if not enemy_action_picker:
		return
	
	var action := enemy_action_picker.get_action()
	if action:
		action.perform_action()


func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_enemy()


func update_enemy() -> void:
	if not stats is EnemyStats: 
		return
	if not is_inside_tree(): 
		await ready
	
	sprite_2d.texture = stats.art
	setup_ai()
	update_stats()


func take_damage(damage: int) -> void:
	stats.take_damage(damage)
	if stats.health <= 0:
		queue_free()


func update_stats() -> void:
	stats_ui.update_stats(stats)


func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
		
	var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self


func _on_area_entered(_area: Area2D) -> void:
	arrow.show()


func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
