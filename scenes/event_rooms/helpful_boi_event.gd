class_name HelpfulBoiEvent
extends EventRoom

@onready var duplicate_last_card_button: EventRoomButton = %DuplicateLastCardButton
@onready var plus_max_hp_button: EventRoomButton = %PlusMaxHPButton


func _ready() -> void:
	character_stats.deck = character_stats.starting_deck.custom_duplicate() # testing code
	
	duplicate_last_card_button.event_button_callback = duplicate_last_card
	plus_max_hp_button.event_button_callback = plus_max_hp


func duplicate_last_card() -> void:
	print(character_stats.deck)
	character_stats.deck.add_card(character_stats.deck.cards[-1].duplicate())
	print(character_stats.deck)


func plus_max_hp() -> void:
	print(character_stats.max_health)
	character_stats.max_health += 5
	print(character_stats.max_health)
