class_name Stats
extends Resource

signal stats_changed

@export var max_health := 1 : set = set_max_health
@export var art: Texture

var health: int : set = set_health
var block: int : set = set_block


func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()


func set_max_health(value : int) -> void:
	var diff := value - max_health
	max_health = value
	
	if diff > 0:
		health += diff
	elif health > max_health:
		health = max_health
	
	stats_changed.emit()


func set_block(value : int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()


func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	block = clampi(block - initial_damage, 0, block)
	health -= damage


func heal(amount : int) -> void:
	health += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
