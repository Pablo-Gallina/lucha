extends PlayerBase

const CHARACTER = GLOBAL.CHARACTERS_TYPES.PAPER

func _ready() -> void:
	super()
	print("Soy un paper")
	jump_force = -1600.0
