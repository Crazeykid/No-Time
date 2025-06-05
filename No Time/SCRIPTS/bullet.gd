extends Area2D

var travelled_distance = 0
func _physics_process(delta: float) -> void:
	const SPEED = 1500
	const RANGE = 2000
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
