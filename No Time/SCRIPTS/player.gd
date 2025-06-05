extends CharacterBody2D

var time := 100
#this is for taking dmg add whatever other time related healthbar bs to it or make a new func if needed
func take_damage(amount: int) -> void:
	time -= amount
	print("player took dmg! Health Now:", time)
	if time <- 0:
		die()

func die():
	print("STUPID FAGGOT FKN DIED")
	# ay u can write ur gamur death logic here







func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 125
	move_and_slide()
