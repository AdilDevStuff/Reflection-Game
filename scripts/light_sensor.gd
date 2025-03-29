extends CharacterBody2D
## IT TAKES 1second to refresh cuz i like it that way
class_name LightSensor2D

var is_light_falling : bool = false
@onready var timer: Timer = $Timer


func on_light_fall() -> void:
	is_light_falling = true
	$Light2D.color = Color(1.0, 0.0, 1.0)
	timer.start()

func on_light_unfall() -> void:
	is_light_falling = false
	$Light2D.color = Color(0.0, 0.0, 0.0)

func _on_timer_timeout() -> void:
	on_light_unfall()
