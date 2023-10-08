extends Panel

@export var char_stats: CharacterStats

@onready var mana_label: Label = $ManaLabel

## TODO fix this in a proper way
func set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	_on_stats_changed()


func _on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [char_stats.mana, char_stats.max_mana]
