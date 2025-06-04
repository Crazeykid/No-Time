extends CollisionShape2D

@onready var muzzle = $PivotPoint/AnimatedSprite2D/Barrel

func _physics_process(delta: float) -> void:
	var cursor = get_global_mouse_position()
	$PivotPoint.look_at(cursor)
