extends Node2D

@onready var timer: Timer = $Health
@onready var health_bar: ProgressBar = $HealthBar

var time_left: float = 100.0
var active := false

func _ready() -> void:
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	begin_game()

func begin_game() -> void:
	time_left = 100.0
	health_bar.max_value = 100.0
	health_bar.value = time_left
	active = true
	timer.start()

func _on_Timer_timeout() -> void:
	if active:
		apply_damage(1.0)

func apply_damage(amount: float) -> void:
	time_left -= amount
	health_bar.value = time_left
	print("Health now:", time_left)
	if time_left <= 0.0:
		die()

func die() -> void:
	active = false
	timer.stop()
	print("Player died.")
