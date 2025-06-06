extends CharacterBody2D

@onready var player_health = $"Player Health"

func take_damage(amount: int) -> void:
	if player_health:
		player_health.apply_damage(amount)
	else:
		print("PlayerHealth not found")

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 125
	move_and_slide()
