extends Node2D

func _ready() -> void:
	var p1_scene = load(GLOBAL.player_selections[0])
	var p2_scene = load(GLOBAL.player_selections[1])

	var p1 = p1_scene.instantiate()
	p1.input_prefix = "p1"
	p1.position = Vector2(-200, 0)
	add_child(p1)

	var p2 = p2_scene.instantiate()
	p2.input_prefix = "p2"
	p2.position = Vector2(200, 0)
	p2.facing_right = false
	add_child(p2)
	
	# Fuerza de golpe por personaje
	var P1_CHARACTER: String = p1.CHARACTER
	var P2_CHARACTER: String = p2.CHARACTER
	# verificar el daño del p1 al p2
	var damageP1: int = get_damage_to_opponent(P1_CHARACTER, P2_CHARACTER)
	p1.hitbox.damage = damageP1
	
	# verificar el daño del p2 al p1
	var damageP2: int = get_damage_to_opponent(P2_CHARACTER, P1_CHARACTER)
	p1.hitbox.damage = damageP2
	
	print(p1.hitbox.damage)
	print(p2.hitbox.damage)

func get_damage_to_opponent(player: String, opponent: String) -> int:
	#print(GLOBAL.DAMAGE_BY_CHARACTERS)
	#var damage_to_opponnent: int = GLOBAL.DAMAGE_BY_CHARACTERS[player][opponent]
	#return damage_to_opponnent
	return 25
