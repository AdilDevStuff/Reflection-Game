extends CharacterBody2D
class_name Player2D

@export var speed: float = 400
@export var jump_force: float = 300
@export var gravity: float = 980

const MIRROR = preload("res://scenes/mirror.tscn")

var current_mirror : Mirror2D
var mouse_pos: Vector2

func _physics_process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	self.position = mouse_pos
	
	#if Input.is_action_just_pressed("left_click"):
		#spawn_obj()
	if Input.is_action_just_pressed("right_click"):
		delete_obj()
	
func spawn_obj():
	var mirror_instance : Node2D = MIRROR.instantiate()
	mirror_instance.position = mouse_pos
	$"../LightRayManager/Mirrors".add_child(mirror_instance)

func delete_obj():
	if current_mirror:
		current_mirror.queue_free()
	print("MIRROR INVALID")
