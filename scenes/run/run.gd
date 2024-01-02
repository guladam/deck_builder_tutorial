class_name Run
extends Node

const BATTLE_SCENE := preload("res://scenes/battle/battle.tscn")
const BATTLE_REWARD_SCENE := preload("res://scenes/battle_reward/battle_reward.tscn")
const CAMPFIRE_SCENE := preload("res://scenes/campfire/campfire.tscn")
const MAP_SCENE := preload("res://scenes/map/map.tscn")
const SHOP_SCENE := preload("res://scenes/shop/shop.tscn")

@onready var current_view: Node = $CurrentView
@onready var map_button: Button = %MapButton
@onready var campfire_button: Button = %CampfireButton
@onready var shop_button: Button = %ShopButton
@onready var battle_reward_button: Button = %BattleRewardButton
@onready var battle_button: Button = %BattleButton
@onready var deck_button: CardPileOpener = %DeckButton
@onready var deck_view: CardPileView = %DeckView
@onready var gold_ui: GoldUI = %GoldUI

var floors_climbed: int
var stats: RunStats
var character: CharacterStats


func _ready() -> void:
	if not character:
		var warrior := load("res://characters/warrior/warrior.tres")
		character = warrior.create_instance()
		start_run()
		
	await get_tree().create_timer(2).timeout
	stats.gold += 57


func start_run() -> void:
	stats = RunStats.new()
	floors_climbed = 0
	_setup_top_bar()
	_setup_event_connections()
	print("TODO: procedurally generate map")
	_change_view(MAP_SCENE)


func _change_view(scene: PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false # need this because of the battle over panel!
	var new_view := scene.instantiate()
	current_view.add_child(new_view)


func _setup_top_bar() -> void:
	gold_ui.run_stats = stats
	deck_button.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_button.pressed.connect(deck_view.show_current_view.bind("Deck"))


func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_on_map_exited)
	
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	battle_reward_button.pressed.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))


func _on_map_exited() -> void:
	floors_climbed += 1
