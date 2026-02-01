extends Control

@onready var label: Label = $Label

func _ready() -> void:
	label.text = GLOBAL.winner + " GANO! Presionar enter para volver a empezar"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Enter"):
		GLOBAL.p1_lives = 2
		GLOBAL.p2_lives = 2
		GLOBAL.player_selections.clear()
		get_tree().change_scene_to_file("res://scenes/select/character_select.tscn")
