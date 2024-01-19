class_name RunInitData
extends Resource

enum Type {NEW_RUN, CONTINUED_RUN}

@export var run_init_type: Type
@export var picked_character: CharacterStats
