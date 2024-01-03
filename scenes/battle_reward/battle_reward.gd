class_name BattleReward
extends Control

enum Type {GOLD, NEW_CARD, RELIC}

const REWARD_BUTTON = preload("res://scenes/ui/reward_button.tscn")
const REWARD_BUTTON_DATA := {
	Type.GOLD: [preload("res://art/gold.png"), "%s gold"],
	Type.NEW_CARD: [preload("res://art/rarity.png"), "Add New Card"]
}

@export var run_stats: RunStats
@export var character_stats: CharacterStats

@onready var rewards: VBoxContainer = %Rewards


func _ready() -> void:
	for node in rewards.get_children():
		node.queue_free()
	
	# this is temp. code, it will come from real battle encounter data
	# as a dependency
	_add_gold_reward(77)
	_add_card_reward()


func _add_gold_reward(amount: int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate() as RewardButton
	gold_reward.reward_icon = REWARD_BUTTON_DATA[Type.GOLD][0]
	gold_reward.reward_text = REWARD_BUTTON_DATA[Type.GOLD][1] % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward)


func _add_card_reward() -> void:
	var card_reward := REWARD_BUTTON.instantiate() as RewardButton
	card_reward.reward_icon = REWARD_BUTTON_DATA[Type.NEW_CARD][0]
	card_reward.reward_text = REWARD_BUTTON_DATA[Type.NEW_CARD][1]
	card_reward.pressed.connect(_show_card_rewards)
	rewards.add_child.call_deferred(card_reward)


func _show_card_rewards() -> void:
	if not run_stats:
		return

	


func _on_gold_reward_taken(amount: int) -> void:
	if not run_stats:
		return
	
	run_stats.gold += amount


func _on_back_button_pressed() -> void:
	Events.battle_reward_exited.emit()
