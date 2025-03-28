extends CharacterBody2D

@export var rotation_speed: float = 60.0

@export var label: Label
@export var mirror_pivot: Node2D

var is_in_range: bool = false

func _process(delta: float) -> void:
	label.visible = is_in_range
	
	# Rotate Mirror
	if is_in_range:
		var direction = Input.get_axis("rotate_left", "rotate_right")
		if direction: mirror_pivot.rotate(deg_to_rad(direction * rotation_speed * delta))
	
	mirror_pivot.rotation = clamp(mirror_pivot.rotation, deg_to_rad(-75), deg_to_rad(75))

func _on_range_body_entered(body:Node2D) -> void:
	is_in_range = true

func _on_range_body_exited(body:Node2D) -> void:
	is_in_range = false
