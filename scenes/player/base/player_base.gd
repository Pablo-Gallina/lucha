class_name PlayerBase
extends CharacterBody2D

@export var speed: float = 450.0
@export var gravity: float = 3000.0
@export var jump_force: float = -1200.0
@export var input_prefix: String = "p1"
@export var facing_right: bool = true
@export var hitbox: Area2D

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement()
	move_and_slide()
	_update_animation()
	_handle_attack()

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

func _handle_jump() -> void:
	if is_on_floor() and Input.is_action_just_pressed(input_prefix + "_jump"):
		velocity.y = jump_force

func _handle_movement() -> void:
	var dir_x := Input.get_axis(
		input_prefix + "_left",
		input_prefix + "_right"
	)
	velocity.x = dir_x * speed

func _update_animation() -> void:
	var sprite = get_node_or_null("Sprite2D")

	if sprite is AnimatedSprite2D:
		if velocity.x != 0:
			sprite.play("run")
			facing_right = velocity.x > 0
		else:
			sprite.play("idle")
		sprite.flip_h = not facing_right

	
func _handle_attack():
	if Input.is_action_just_pressed(input_prefix + "_punch"):
		attack()

func attack():
	hitbox.enable()
	await get_tree().create_timer(0.1).timeout
	hitbox.disable()

func take_damage(amount: int) -> void:
	print("Recibí daño:", amount)
