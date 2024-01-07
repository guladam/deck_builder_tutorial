class_name CardPileView
extends Control

const CARD_MENU_UI_SCENE := preload("res://scenes/ui/card_menu_ui.tscn")

@export var card_pile: CardPile

@onready var title: Label = %Title
@onready var cards: GridContainer = %Cards
@onready var tooltip_popup: Control = %TooltipPopup
@onready var tooltip_card: CenterContainer = %TooltipCard
@onready var card_description: RichTextLabel = %CardDescription
@onready var back_button: Button = %BackButton


func _ready() -> void:
	back_button.pressed.connect(hide)
	
	for card in cards.get_children():
		card.queue_free()

	for card in tooltip_card.get_children():
		card.queue_free()
	
	_hide_tooltip()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if tooltip_popup.visible:
			_hide_tooltip()
		else:
			hide()


func show_current_view(new_title: String, randomized: bool = false) -> void:
	for card in cards.get_children():
		card.queue_free()
		
	_hide_tooltip()
	title.text = new_title
	_update_view.call_deferred(randomized)


func _update_view(randomized: bool) -> void:
	if not card_pile:
		return
	
	var all_cards := card_pile.cards.duplicate()
	if randomized:
		all_cards.shuffle()
	
	for card: Card in all_cards:
		var new_card := CARD_MENU_UI_SCENE.instantiate() as CardMenuUI
		cards.add_child(new_card)
		new_card.card = card
		new_card.tooltip_requested.connect(_show_tooltip)
		
	show()


func _show_tooltip(card: Card) -> void:
	var new_card := CARD_MENU_UI_SCENE.instantiate() as CardMenuUI
	tooltip_card.add_child(new_card)
	new_card.card = card
	new_card.tooltip_requested.connect(_hide_tooltip.unbind(1))
	card_description.text = card.get_default_tooltip()
	tooltip_popup.show()


func _hide_tooltip() -> void:
	if not tooltip_popup.visible:
		return

	for card in tooltip_card.get_children():
		card.queue_free()
	
	tooltip_popup.hide()


func _on_tooltip_popup_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		_hide_tooltip()
