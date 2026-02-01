extends PlayerBase

const CHARACTER = GLOBAL.CHARACTERS_TYPES.ROCK

func _ready() -> void:
	print("Soy una roca")
	speed = 200
	jump_force = -800.0
	hit_velocity = 0.6
