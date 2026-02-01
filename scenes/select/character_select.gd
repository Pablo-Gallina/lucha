extends Control
																																																										 
var selections: Array = []
var current_player: int = 1
																																																										 
@onready var label: Label = $Label
@onready var btn_rock: TextureButton = $HBoxContainer/BtnRock
@onready var btn_paper: TextureButton = $HBoxContainer/BtnPaper
@onready var btn_scissors: TextureButton = $HBoxContainer/BtnScissors                                                                                                                                                                         
																																																										 
func _ready() -> void:
	btn_rock.pressed.connect(_on_character_selected.bind("res://scenes/player/rock/rock.tscn"))
	btn_paper.pressed.connect(_on_character_selected.bind("res://scenes/player/paper/player.tscn"))
	btn_scissors.pressed.connect(_on_character_selected.bind("res://scenes/player/scisors/scisors.tscn"))
	_update_label()
																																																										 
func _on_character_selected(scene_path: String) -> void:
	selections.append(scene_path)
	current_player += 1
																																																										 
	if current_player > 2:
		# Ambos eligieron, guardar en GLOBAL y ir al ring                                                                                                                                                                              
		GLOBAL.player_selections = selections
		get_tree().change_scene_to_file("res://scenes/ring/ring.tscn")
	else:
		_update_label()

func _update_label() -> void:
	label.text = "JUGADOR %d - ELIGE TU PERSONAJE" % current_player
