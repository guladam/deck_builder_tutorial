class_name Room
extends Resource

enum Type {NOT_ASSIGNED, MONSTER, TREASURE, CAMPFIRE, SHOP, BOSS, EVENT}

@export var type: Type
@export var row: int
@export var column: int
@export var position: Vector2
@export var next_rooms: Array[Room]
@export var selected := false
# This is only used by the MONSTER and BOSS types
@export var battle_stats: BattleStats
# This is only used by the EVENT room type
@export var event_scene: PackedScene


func _to_string() -> String:
	return "%s (%s)" % [column, Type.keys()[type][0]]
