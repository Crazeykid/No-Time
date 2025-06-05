extends Area2D

@export var target_scene: PackedScene

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		if target_scene:
			get_tree().change_scene_to_packed(target_scene)
		else:
			print("target scene not working or set")
