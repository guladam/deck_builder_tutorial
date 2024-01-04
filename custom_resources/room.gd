class_name Room
extends RefCounted

enum Type {MONSTER, TREASURE, CAMPFIRE, SHOP}

var type: Type
var row: int
var column: int
var position: Vector2
var next_rooms: Array[Room]


func _to_string() -> String:
	return "Room%s(%6s)" % [row*7 + column, _get_connections()]


func _get_connections() -> String:
	var nums: PackedStringArray = []
	for room in next_rooms:
		nums.append(str(room.row*7 + room.column))
	return "-".join(nums)
