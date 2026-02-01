extends Node2D

const PLAYER_INDICATOR = preload("uid://tqlhfhbrkjkj")

func _ready() -> void:
	var p1_scene = load(GLOBAL.player_selections[0])
	var p2_scene = load(GLOBAL.player_selections[1])

	var p1 = p1_scene.instantiate()
	p1.input_prefix = "p1"
	p1.position = Vector2(-200, 0)
	p1.modulate = Color.LIGHT_SKY_BLUE
	add_child(p1)
	var ind1 = PLAYER_INDICATOR.instantiate()
	ind1.position = Vector2(0, -90)
	p1.add_child(ind1)
	ind1.setup("J1", Color.REBECCA_PURPLE)

	var p2 = p2_scene.instantiate()
	p2.input_prefix = "p2"
	p2.position = Vector2(200, 0)
	p2.modulate = Color.GOLD
	p2.facing_right = false
	add_child(p2)
	var ind2 = PLAYER_INDICATOR.instantiate()
	ind2.position = Vector2(0, -90)
	p2.add_child(ind2)
	ind2.setup("J2", Color.ORANGE)
	
	# Fuerza de golpe por personaje
	var P1_CHARACTER: String = p1.CHARACTER
	var P2_CHARACTER: String = p2.CHARACTER
	# verificar el daño del p1 al p2
	var damageP1: int = get_damage_to_opponent(P1_CHARACTER, P2_CHARACTER)
	p1.hitbox.damage = damageP1
	
	# verificar el daño del p2 al p1
	var damageP2: int = get_damage_to_opponent(P2_CHARACTER, P1_CHARACTER)
	p2.hitbox.damage = damageP2

	p1.died.connect(_on_player_died.bind("p1"))
	p2.died.connect(_on_player_died.bind("p2"))

func _on_player_died(player: String) -> void:
	if player == "p1":
		GLOBAL.p1_lives -= 1
	else:
		GLOBAL.p2_lives -= 1

	if GLOBAL.p1_lives <= 0 or GLOBAL.p2_lives <= 0:
		GLOBAL.winner = "JUGADOR 2" if GLOBAL.p1_lives <= 0 else "JUGADOR 1"
		get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")
	else:
		GLOBAL.player_selections.clear()
		get_tree().change_scene_to_file("res://scenes/select/character_select.tscn")

func get_damage_to_opponent(player: String, opponent: String) -> int:
	print(GLOBAL.DAMAGE_BY_CHARACTERS)
	var damage_to_opponnent: int = GLOBAL.DAMAGE_BY_CHARACTERS[player][opponent]
	return damage_to_opponnent
