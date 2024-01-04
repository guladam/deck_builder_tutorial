class_name MapRoom
extends Area2D

var room: Room : set = set_room


func set_room(new_data: Room) -> void:
	room = new_data
	position = room.position
