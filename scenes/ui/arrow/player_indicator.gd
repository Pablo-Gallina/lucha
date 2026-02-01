extends Node2D

@onready var label : Label = $Label
@onready var arrow : AnimatedSprite2D = $Arrow

func setup (text: String, color: Color) -> void:
	label.position.y = -50
	label.position.x = -5
	label.text = text
	label.modulate = color
	arrow.modulate = color
	arrow.play("default")
