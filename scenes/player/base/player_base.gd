class_name PlayerBase
extends CharacterBody2D

@onready var _sprite: AnimatedSprite2D = $Sprite2D

@export var speed: float = 450.0
@export var gravity: float = 3000.0
@export var jump_force: float = -1200.0
@export var input_prefix: String = "p1"
@export var facing_right: bool = true
@export var hitbox: Area2D
@export var max_health: int = 100
@export var health: int = 100
@export var hit_velocity: float = 0.4
@export var delay_hit: float = 0
var _is_delay_hit := false

signal health_changed(new_health: int)
signal died

var is_attacking: bool = false
var is_stunned: bool = false
var punch_offset: float = 20.0
var is_figthing: bool = false
var _health_label := Label.new()
@export var stun_duration: float = 0.2

var _shadow: Sprite2D
var _floor_y: float = 0.0

func _ready() -> void:
	add_child(_health_label)
	
	_health_label.position = Vector2(-15, -160)
	_health_label.text = str(health) + "%"
	if input_prefix == "p1":
		_health_label.modulate = Color.REBECCA_PURPLE
	else:
		_health_label.modulate = Color.ORANGE
	_floor_y = global_position.y
	_shadow = Sprite2D.new()
	var img := Image.create(96, 24, false, Image.FORMAT_RGBA8)
	var center := Vector2(48, 12)
	var radius := Vector2(48, 12)
	for x in 96:
		for y in 24:
			var dist := Vector2((x - center.x) / radius.x, (y - center.y) / radius.y).length()
			if dist <= 1.0:
				var alpha := (1.0 - dist) * 0.5
				img.set_pixel(x, y, Color(0, 0, 0, alpha))
	_shadow.texture = ImageTexture.create_from_image(img)
	add_child(_shadow)
	move_child(_shadow, 0)

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	if not is_attacking and not is_stunned and not _is_delay_hit:
		_handle_movement()
		_handle_jump()
	else:
		velocity.x = 0
	move_and_slide()
	_update_animation()
	_handle_attack()
	_update_shadow()

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0
		_floor_y = global_position.y

func _handle_jump() -> void:
	if is_on_floor() and not is_stunned and Input.is_action_just_pressed(input_prefix + "_jump"):
		velocity.y = jump_force

func _handle_movement() -> void:
	var dir_x := Input.get_axis(
		input_prefix + "_left",
		input_prefix + "_right"
	)
	velocity.x = dir_x * speed

func _update_animation() -> void:
	if not _sprite is AnimatedSprite2D:
		return

	if is_stunned:
		return

	if is_figthing or _is_delay_hit:
		if _sprite.animation != "punch":
			_sprite.position.x = punch_offset if facing_right else -punch_offset
			_sprite.play("punch")
	elif not is_on_floor():
		if _sprite.animation != "jump":
			_sprite.play("jump")
		if velocity.x != 0:
			facing_right = velocity.x > 0
	elif velocity.x != 0:
		_sprite.play("run")
		facing_right = velocity.x > 0
	else:
		_sprite.play("idle")
	_sprite.flip_h = not facing_right
	if hitbox:
		hitbox.scale.x = 1 if facing_right else -1

func _handle_attack():
	if Input.is_action_just_pressed(input_prefix + "_punch") and !is_figthing and !_is_delay_hit and !is_stunned:
		_is_delay_hit = true
		await get_tree().create_timer(delay_hit).timeout
		if is_stunned:
			_is_delay_hit = false
			return
		print("pegue")
		attack()

func attack():
	_sprite.position.x = punch_offset if facing_right else -punch_offset
	_sprite.play("punch")
	hitbox.enable()
	is_figthing = true
	await get_tree().create_timer(hit_velocity).timeout
	hitbox.disable()
	is_figthing = false
	_is_delay_hit = false
	_sprite.position.x = 0

func take_damage(amount: int) -> void:
	health = max(health - amount, 0)
	_health_label.text = str(health) + "%"
	health_changed.emit(health)
	is_stunned = true
	_sprite.play("hit")
	_sprite.modulate = Color.RED
	await get_tree().create_timer(stun_duration).timeout
	_sprite.modulate = Color.WHITE
	is_stunned = false
	if health == 0:
		_on_died()

func _update_shadow() -> void:
	var height_diff := _floor_y - global_position.y
	_shadow.global_position = Vector2(global_position.x - 10, _floor_y + 64)
	var scale_factor := clampf(1.0 - height_diff / 600.0, 0.3, 1.0)
	_shadow.scale = Vector2(scale_factor, scale_factor)
	_shadow.modulate.a = scale_factor

func _on_died() -> void:
	died.emit()
	queue_free()
