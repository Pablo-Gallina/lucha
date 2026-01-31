class_name PlayerBase
extends CharacterBody2D

var speed : float = 200
@export var input_prefix: String = "p1"

func _process(_delta: float) -> void:
	_motion_ctrl()

func _motion_ctrl():
	var dir_x = Input.get_axis(input_prefix + "_left", input_prefix + "_right")
	velocity.x = dir_x * speed
	move_and_slide()
