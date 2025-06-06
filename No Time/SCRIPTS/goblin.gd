extends CharacterBody2D

@onready var player = $"../Player"
var damage_cooldown := 1.0
var time_since_last_hit := 0.0

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	time_since_last_hit += delta

	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100
	move_and_slide()

	var anim_name = get_animation_name(direction) #animation
	$AnimatedSprite2D.play(anim_name)

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() == player and time_since_last_hit >= damage_cooldown:
			if player.has_method("take_damage"):
				player.take_damage(10)
				time_since_last_hit = 0.0


func get_animation_name(direction: Vector2) -> String: #animation
	if direction == Vector2.ZERO:
		return "Idle"
	else:
		if direction.y < 0:
			return "Up Walk"
		else:
			return "Down Walk"
