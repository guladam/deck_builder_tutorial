extends Node2D

@export var char_stats: CharacterStats

@onready var player: Player = $Player
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var battle_ui: BattleUI = $BattleUI


func _ready() -> void:
	# Normally, we would do this on a 'Run'
	# level so we keep our health, gold and deck
	# between battles.
	var new_stats: CharacterStats = char_stats.create_instance()
	player.stats = new_stats
	battle_ui.char_stats = new_stats
	
	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	Events.enemy_turn_ended.connect(player_handler.start_turn)
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	
	player_handler.start_battle(new_stats)


func _on_enemies_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("won battle!")


func _on_player_died() -> void:
	print("game over!")
