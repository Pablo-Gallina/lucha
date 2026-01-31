extends Area2D

@export var damage: int = 1

func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("detectamos algo")
	if body.has_method("take_damage"):
		body.take_damage(damage)

func enable() -> void:
	monitoring = true

func disable() -> void:
	monitoring = false
