class_name HelpfulBoiEvent
extends EventRoom

@onready var duplicate_last_card_button: EventRoomButton = %DuplicateLastCardButton
@onready var plus_max_hp_button: EventRoomButton = %PlusMaxHPButton


func _ready() -> void:
	duplicate_last_card_button.event_button_callback = duplicate_last_card
	plus_max_hp_button.event_button_callback = plus_max_hp


func duplicate_last_card() -> void:
	character_stats.deck.add_card(character_stats.deck.cards[-1].duplicate())


func plus_max_hp() -> void:
	character_stats.max_health += 5
