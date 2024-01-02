extends Control

const RUN_SCENE := preload("res://scenes/run/run.tscn")
const WARRIOR_STATS := preload("res://characters/warrior/warrior.tres")
const WIZARD_STATS := preload("res://characters/assassin/assassin.tres")
const ASSASSIN_STATS := preload("res://characters/wizard/wizard.tres")

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var character_portrait: TextureRect = %CharacterPortrait
@onready var current_character := WARRIOR_STATS : set = set_current_character


func set_current_character(new_character: CharacterStats) -> void:
	current_character = new_character
	title.text = current_character.character_name
	description.text = current_character.description
	character_portrait.texture = current_character.portrait
	

func _on_start_button_pressed() -> void:
	var new_run: Run = RUN_SCENE.instantiate() as Run
	new_run.character = current_character.create_instance()

	get_tree().root.add_child(new_run)	
	new_run.start_run()
	
	queue_free()


func _on_warrior_button_pressed() -> void:
	current_character = WARRIOR_STATS


func _on_wizard_button_pressed() -> void:
	current_character = WIZARD_STATS


func _on_assassin_button_pressed() -> void:
	current_character = ASSASSIN_STATS
