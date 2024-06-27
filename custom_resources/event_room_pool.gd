class_name EventRoomPool
extends Resource

@export var event_rooms: Array[PackedScene]


func get_random() -> PackedScene:
	return event_rooms.pick_random()
