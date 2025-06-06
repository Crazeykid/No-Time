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

	var anim_name = get_animation_name(direction)
	$AnimatedSprite2D.play(anim_name)
	
	if anim_name == "Side Walk":
		$AnimatedSprite2D.flip_h = direction.x > 0
	else:
		$AnimatedSprite2D.flip_h = false

func get_animation_name(direction: Vector2) -> String:
	if direction == Vector2.ZERO:
		return "Idle"
	elif abs(direction.x) > abs(direction.y): #abs is the amount away from 0 so in this case direction x is a stronger pull than direction y it will play side anim
		return "Side Walk"
	else:
		if direction.y < 0:
			return "Up Walk"
		else:
			return "Down Walk"
