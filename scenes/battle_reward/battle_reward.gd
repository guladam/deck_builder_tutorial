class_name BattleReward
extends Control

const REWARD_BUTTON = preload("res://scenes/ui/reward_button.tscn")
const REWARD_BUTTON_DATA := {
	Type.GOLD: [preload("res://art/gold.png"), "%s gold"],
	Type.NEW_CARD: [preload("res://art/rarity.png"), "Add New Card"]
}

enum Type {GOLD, NEW_CARD, RELIC}

@export var run_stats: RunStats
@export var character_stats: CharacterStats
@export var relic_handler: RelicHandler

@onready var rewards: VBoxContainer = %Rewards
@onready var card_rewards: CardRewards = %CardRewards

var card_reward_total_weight := 0.0
var card_rarity_weights := {
	Card.Rarity.COMMON: 0.0,
	Card.Rarity.UNCOMMON: 0.0,
	Card.Rarity.RARE: 0.0
}


func _ready() -> void:
	for node: Node in rewards.get_children():
		node.queue_free()
	
	card_rewards.card_reward_selected.connect(_on_card_reward_taken)


func add_gold_reward(amount: int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate() as RewardButton
	gold_reward.reward_icon = REWARD_BUTTON_DATA[Type.GOLD][0]
	gold_reward.reward_text = REWARD_BUTTON_DATA[Type.GOLD][1] % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward)


func add_card_reward() -> void:
	var card_reward := REWARD_BUTTON.instantiate() as RewardButton
	card_reward.reward_icon = REWARD_BUTTON_DATA[Type.NEW_CARD][0]
	card_reward.reward_text = REWARD_BUTTON_DATA[Type.NEW_CARD][1]
	card_reward.pressed.connect(_show_card_rewards)
	rewards.add_child.call_deferred(card_reward)


func add_relic_reward(relic: Relic) -> void:
	var relic_reward := REWARD_BUTTON.instantiate() as RewardButton
	relic_reward.reward_icon = relic.icon
	relic_reward.reward_text = relic.relic_name
	relic_reward.pressed.connect(_on_relic_reward_taken.bind(relic))
	rewards.add_child.call_deferred(relic_reward)


func _show_card_rewards() -> void:
	if not run_stats or not character_stats:
		return
	
	var card_reward_array: Array[Card] = []
	var available_cards := character_stats.draftable_cards.cards.duplicate(true)
	
	for i in run_stats.card_rewards:
		_setup_card_chances()
		var roll := RNG.instance.randf_range(0.0, card_reward_total_weight)
		
		for rarity: Card.Rarity in card_rarity_weights:
			if card_rarity_weights[rarity] > roll:
				_modify_weights(rarity)
				var picked_card := _get_random_available_card(available_cards, rarity)
				card_reward_array.append(picked_card)
				available_cards.erase(picked_card)
				break

	card_rewards.rewards = card_reward_array
	card_rewards.show()
	

func _setup_card_chances() -> void:
	card_reward_total_weight = run_stats.common_weight + run_stats.uncommon_weight + run_stats.rare_weight
	card_rarity_weights[Card.Rarity.COMMON] = run_stats.common_weight
	card_rarity_weights[Card.Rarity.UNCOMMON] = run_stats.common_weight + run_stats.uncommon_weight
	card_rarity_weights[Card.Rarity.RARE] = card_reward_total_weight


func _modify_weights(rarity_rolled: Card.Rarity) -> void:
	if rarity_rolled == Card.Rarity.RARE:
		run_stats.rare_weight = RunStats.BASE_RARE_WEIGHT
	else:
		run_stats.rare_weight = clampf(run_stats.rare_weight + 0.3, run_stats.BASE_RARE_WEIGHT, 5.0)


func _get_random_available_card(available_cards: Array[Card], with_rarity: Card.Rarity) -> Card:
	var all_possible_cards := available_cards.filter(
		func(card: Card):
			return card.rarity == with_rarity
	)
	return RNG.array_pick_random(all_possible_cards)


func _on_gold_reward_taken(amount: int) -> void:
	if not run_stats:
		return
	
	run_stats.gold += amount


func _on_card_reward_taken(card: Card) -> void:
	if not character_stats or not card:
		return
		
	character_stats.deck.add_card(card)


func _on_relic_reward_taken(relic: Relic) -> void:
	if not relic or not relic_handler:
		return
		
	relic_handler.add_relic(relic)


func _on_back_button_pressed() -> void:
	Events.battle_reward_exited.emit()
