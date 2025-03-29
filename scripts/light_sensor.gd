extends CharacterBody2D

var is_light_falling : bool = false


func on_light_fall() -> void:
	is_light_falling = true
	$Light2D.color = Color(1.0, 0.0, 1.0)

func on_light_unfall() -> void:
	is_light_falling = false
	$Light2D.color = Color(0.0, 0.0, 0.0)
