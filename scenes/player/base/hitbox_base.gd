class_name HitboxBase
extends Area2D

@export var damage: int = 25
var _has_hit := false

func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _has_hit:
		return
	if body.has_method("take_damage"):
		_has_hit = true
		body.take_damage(damage)

func enable() -> void:
	_has_hit = false
	monitoring = true

func disable() -> void:
	monitoring = false
