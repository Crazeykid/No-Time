extends Node2D
@onready var health: Timer = $Health
@onready var health_bar: ProgressBar = $HealthBar
static var timeLeft = 100
var active = false

func beginGame() -> void:
	health.start(timeLeft)
	set_health_bar()
	active = true
	while(active):
		set_health_bar()
		print(health)

func _input(event: InputEvent) -> void:
	beginGame()

func set_health_bar() -> void:
	$HealthBar.value = health

func _on_TimerTimeout() -> void:
	queue_free()
