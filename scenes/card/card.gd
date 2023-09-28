class_name Card
extends Control

@export var data: CardData

@onready var color: ColorRect = $Color
@onready var status: Label = $Status
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@onready var original_index := self.get_index()
@onready var parent := self.get_parent()
@onready var targets: Array[Area2D] = []


func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
