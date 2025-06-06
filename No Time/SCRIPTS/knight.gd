extends CharacterBody2D

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

@onready var player = get_node("%Player")

var damage_cooldown := 1.0
var time_since_last_hit := 0.0

var detection_range := 75.0  # Distance for dash start
var dash_speed := 500.0       # Speed during dash
var normal_speed := 60.0

var is_waiting := false       # True when knight is stopped and waiting
var wait_time := 0.5          # Time to wait before dashing
var wait_timer := 0.0         # Timer counting how long knight has waited
var is_dashing := false       # True while knight is dashing
var dash_direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	time_since_last_hit += delta

	var distance_to_player = global_position.distance_to(player.global_position)
	
	if is_dashing:
		velocity = dash_direction * dash_speed
		move_and_slide()
		wait_timer += delta
		if wait_timer >= 0.5: # DASH LENGTH
			is_dashing = false
			wait_timer = 0.0

	elif is_waiting:
		velocity = Vector2.ZERO
		move_and_slide()
		
		wait_timer += delta
		if wait_timer >= wait_time:
			is_waiting = false
			is_dashing = true
			wait_timer = 0.0
			dash_direction = global_position.direction_to(player.global_position)
	else:
		if distance_to_player > detection_range: #SET TO NORM SPEED
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * normal_speed
			move_and_slide()
		else:
			is_waiting = true
			wait_timer = 0.0
			velocity = Vector2.ZERO
			move_and_slide()

	# Handle collisions and damage
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() == player and time_since_last_hit >= damage_cooldown:
			if player.has_method("take_damage"):
				player.take_damage(20)
				time_since_last_hit = 0.0
