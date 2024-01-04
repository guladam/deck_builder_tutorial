class_name Room
extends RefCounted

enum Type {NOT_ASSIGNED, MONSTER, TREASURE, CAMPFIRE, SHOP, BOSS}

var type: Type
var row: int
var column: int
var position: Vector2
var next_rooms: Array[Room]
