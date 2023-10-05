extends Panel

@export var char_stats: CharacterStats

@onready var mana_label: Label = $ManaLabel


func _ready() -> void:
	if char_stats:
		char_stats.stats_changed.connect(_on_stats_changed)


func set_char_stats(value: CharacterStats) -> void:
	if char_stats:
		char_stats.stats_changed.disconnect(_on_stats_changed)
	
	char_stats = value
	char_stats.stats_changed.connect(_on_stats_changed)
	_on_stats_changed()


func _on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [char_stats.mana, char_stats.max_mana]
