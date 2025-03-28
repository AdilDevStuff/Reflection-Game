extends Node2D

const MIRROR = preload("res://scenes/mirror.tscn")
var mouse_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	if Input.is_action_pressed("Click"):
		spawn_obj()
	
func spawn_obj():
	var mirror_instance : Node2D = MIRROR.instantiate()
	mirror_instance.position = mouse_pos
	add_child(mirror_instance)
