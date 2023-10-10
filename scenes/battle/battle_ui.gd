class_name BattleUI
extends CanvasLayer

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var hand: Hand = $Hand
@onready var end_turn_button: Button = %EndTurnButton
@onready var mana_ui: ManaUI = %ManaUI
@onready var card_tooltip: Tooltip = %CardTooltip


func _ready() -> void:
	Events.card_tooltip_requested.connect(card_tooltip.show_tooltip)
	Events.tooltip_hide_requested.connect(card_tooltip.hide_tooltip)
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	Events.player_died.connect(_on_player_died)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)


func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	hand.char_stats = char_stats
	mana_ui.char_stats = char_stats


func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false


func _on_player_died() -> void:
	hand.hide()
	end_turn_button.hide()
	mana_ui.hide()


func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
