class_name RelicHandler
extends HBoxContainer

signal relics_activated(type: Relic.Type)

const RELIC_APPLY_INTERVAL := 0.5
const RELIC_UI = preload("res://scenes/relic_handler/relic_ui.tscn")

@onready var relics_control: RelicsControl = $RelicsControl
@onready var relics: HBoxContainer = %Relics


func activate_relics_by_type(type: Relic.Type) -> void:
	if type == Relic.Type.EVENT_BASED:
		return
		
	var relic_queue: Array[RelicUI] = _get_all_relic_ui_nodes().filter(
		func(relic_ui: RelicUI):
			return relic_ui.relic.type == type
	)
	if relic_queue.is_empty():
		relics_activated.emit(type)
		return
	
	var tween := create_tween()
	for relic_ui: RelicUI in relic_queue:
		tween.tween_callback(relic_ui.relic.activate_relic.bind(relic_ui))
		tween.tween_interval(RELIC_APPLY_INTERVAL)
	
	tween.finished.connect(func(): relics_activated.emit(type))


func add_relic(relic: Relic) -> void:
	if has_relic(relic.id):
		return
	
	var new_relic_ui: RelicUI = RELIC_UI.instantiate() as RelicUI
	relics.add_child(new_relic_ui)
	new_relic_ui.relic = relic
	new_relic_ui.relic.initialize_relic(new_relic_ui)
	

func has_relic(id: String) -> bool:
	for relic_ui: RelicUI in relics.get_children():
		if relic_ui.relic.id == id and not relic_ui.is_queued_for_deletion():
			return true

	return false


func _get_all_relic_ui_nodes() -> Array[RelicUI]:
	var all_relics: Array[RelicUI] = []
	for relic_ui: RelicUI in relics.get_children():
		all_relics.append(relic_ui)
		
	return all_relics
