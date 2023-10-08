extends Node2D


@export var char_stats: CharacterStats

@onready var player: Player = $Player
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var end_turn_button: Button = %EndTurnButton
@onready var mana_ui: Panel = %ManaUI
@onready var card_tooltip: PanelContainer = %CardTooltip



func _ready() -> void:
	# We need this for testing purposes
	# since there is no deck in a 'per-run' level
	if not char_stats.deck:
		char_stats.deck = char_stats.starting_deck.duplicate()
	
	player.stats = char_stats
	player_handler.character = char_stats
	mana_ui.char_stats = char_stats
	
	end_turn_button.pressed.connect(player_handler.end_turn)
	player_handler.start_battle(char_stats)
	
	# TODO is this really concerns the whole battle?
	# Maybe move a bunch of stuff to the UI from here
	Events.card_tooltip_requested.connect(card_tooltip.show_tooltip)
	Events.tooltip_hide_requested.connect(card_tooltip.hide_tooltip)
