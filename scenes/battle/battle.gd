extends Node2D

@export var char_stats: CharacterStats

@onready var player: Player = $Player
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var battle_ui: BattleUI = $BattleUI


func _ready() -> void:
	# Normally, we would do this on a 'Run'
	# level so we keep our health, gold and deck
	# between battles.
	var new_stats: CharacterStats = char_stats.create_instance()
	
	player.stats = new_stats
	battle_ui.char_stats = new_stats
	battle_ui.end_turn_button.pressed.connect(player_handler.end_turn)
	player_handler.character = new_stats
	player_handler.start_battle(new_stats)
