class_name Stats
extends Resource

signal stats_changed

@export var max_health := 1
@export var art: Texture

var health: int : set = set_health
var block: int : set = set_block


func set_health(value : int) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("stats_changed")


func set_block(value : int) -> void:
	block = max(value, 0)
	emit_signal("stats_changed")


func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage -= block
	self.block = clamp(block - initial_damage, 0, block)
	self.health -= damage


func heal(amount : int) -> void:
	self.health += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
