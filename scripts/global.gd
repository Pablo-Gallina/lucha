extends Node

var score : int
var axis : Vector2
var player_selections: Array = []
var p1_lives : int = 2
var p2_lives : int = 2

const CHARACTERS_TYPES = {
	"SCISSORS": "sci",
	"ROCK": "roc",
	"PAPER": "pap",
}

const DAMAGE_BY_CHARACTERS = {
	CHARACTERS_TYPES.SCISSORS: {
		CHARACTERS_TYPES.SCISSORS: 25,
		CHARACTERS_TYPES.PAPER: 50,
		CHARACTERS_TYPES.ROCK: 12,
	},
	CHARACTERS_TYPES.PAPER: {
		CHARACTERS_TYPES.PAPER: 35,
		CHARACTERS_TYPES.SCISSORS: 10,
		CHARACTERS_TYPES.ROCK: 25,
	},
	CHARACTERS_TYPES.ROCK: {
		CHARACTERS_TYPES.ROCK: 25,
		CHARACTERS_TYPES.SCISSORS: 100,
		CHARACTERS_TYPES.PAPER: 50,
	}
}

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
