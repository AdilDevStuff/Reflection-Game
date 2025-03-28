extends Node2D

const MIRROR = preload("res://scenes/mirror.tscn")
var mouse_pos: Vector2

func _process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("Click"):
		spawn_obj()

func spawn_obj():
	var mirror_instance : Node2D = MIRROR.instantiate()
	mirror_instance.position = mouse_pos
	add_child(mirror_instance)
