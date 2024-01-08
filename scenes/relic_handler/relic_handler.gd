class_name RelicHandler
extends HBoxContainer

signal relics_activated(type: Relic.Type)

const RELIC_APPLY_INTERVAL := 0.25
const RELIC_UI = preload("res://scenes/relic_handler/relic_ui.tscn")

@onready var relics_control: RelicsControl = $RelicsControl
@onready var relics: HBoxContainer = %Relics


func _ready() -> void:
	var available_relics := [
		preload("res://relics/reinforced_armor.tres"),
		preload("res://relics/coupons.tres"),
		preload("res://relics/endless_healing_potion.tres"),
		preload("res://relics/explosive_barrel.tres"),
		preload("res://relics/rechargable_mana_potion.tres")
	]
	for i in 10:
		await get_tree().create_timer(2).timeout
		add_relic(available_relics.pick_random())


func activate_relics_by_type(type: Relic.Type) -> void:
	if type == Relic.Type.EVENT_BASED:
		return
		
	var relic_queue: Array[Relic] = _get_all_relics().filter(
		func(relic: Relic):
			return relic.type == type
	)
	if relic_queue.is_empty():
		relics_activated.emit(type)
		return
	
	var tween := create_tween()
	for relic: Relic in relic_queue:
		tween.tween_callback(relic.activate_relic)
		tween.tween_interval(RELIC_APPLY_INTERVAL)
	
	tween.finished.connect(func(): relics_activated.emit(type))


func add_relic(relic: Relic) -> void:
	if _has_relic(relic.id):
		return
	
	var new_relic_ui: RelicUI = RELIC_UI.instantiate() as RelicUI
	relics.add_child(new_relic_ui)
	new_relic_ui.relic = relic
	new_relic_ui.relic.initialize_relic()
	relics_control.update()
	

func _has_relic(id: String) -> bool:
	for relic_ui: RelicUI in relics.get_children():
		if relic_ui.relic.id == id:
			return true

	return false


func _get_all_relics() -> Array[Relic]:
	var all_relics: Array[Relic] = []
	for relic_ui: RelicUI in relics.get_children():
		all_relics.append(relic_ui.relic)
		
	return all_relics
