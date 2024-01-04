class_name Room
extends RefCounted

enum Type {MONSTER, TREASURE, CAMPFIRE, SHOP}

var type: Type
var row: int
var column: int
var position: Vector2
var next_rooms: Array[Room]
