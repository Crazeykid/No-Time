extends CharacterBody2D

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

@onready var player = get_node("%Player")
var damage_cooldown := 1.0
var time_since_last_hit := 0.0

func _physics_process(delta: float) -> void:
	time_since_last_hit += delta

	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 50
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() == player and time_since_last_hit >= damage_cooldown:
			if player.has_method("take_damage"):
				player.take_damage(5)
				time_since_last_hit = 0.0
