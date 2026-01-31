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
	add_child(p2)
