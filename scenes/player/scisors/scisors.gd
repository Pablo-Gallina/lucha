extends PlayerBase

const CHARACTER = GLOBAL.CHARACTERS_TYPES.SCISSORS

func _ready() -> void:
	super()
	print("Soy una tijera")
	speed = 600
