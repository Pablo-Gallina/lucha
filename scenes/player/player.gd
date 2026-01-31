extends CharacterBody2D

var speed : float = 200

func _process(_delta: float) -> void:
	_motion_ctrl()

func _motion_ctrl():
	velocity.x = GLOBAL.get_axis().x * speed
	#velocity.y = GLOBAL.get_axis().y * speed
	move_and_slide()
