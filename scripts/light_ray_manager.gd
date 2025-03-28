extends Node2D

var rot: float = 0.0
var bounces: int = 3
var lasers: Array = []
var max_cast_to: Vector2

const MAX_LENGTH: float = 2000.0

@export var line: Line2D
@export var light_ray: RayCast2D
@export var light_source: CharacterBody2D
@export var ray_origin_marker: Marker2D

func _ready() -> void:
	setup_lasers()
	setup_initial_state()

func setup_lasers() -> void:
	lasers.append(light_ray)
	for i in range(bounces):
		var raycast = light_ray.duplicate()
		raycast.enabled = false
		add_child(raycast)
		lasers.append(raycast)

func setup_initial_state() -> void:
	max_cast_to = Vector2(MAX_LENGTH, 0).rotated(rot)
	light_ray.target_position = max_cast_to
	line.top_level = true

func _process(_delta: float) -> void:
	reset_line()
	update_lasers()

func reset_line() -> void:
	line.clear_points()
	line.add_point(ray_origin_marker.global_position)
	max_cast_to = Vector2(MAX_LENGTH, 0).rotated(rot)

func update_lasers() -> void:
	for idx in lasers.size():
		var raycast = lasers[idx]
		var raycast_collision = raycast.get_collision_point()

		setup_raycast(raycast, idx)

		if raycast.is_colliding():
			handle_collision(raycast, raycast_collision, idx)
		else:
			line.add_point(raycast.global_position + max_cast_to)
			break

func setup_raycast(raycast: RayCast2D, idx: int) -> void:
	raycast.target_position = max_cast_to
	if idx == 0:
		raycast.global_position = ray_origin_marker.global_position

func handle_collision(raycast: RayCast2D, raycast_collision: Vector2, idx: int) -> void:
	var collider = raycast.get_collider()
	if collider.is_in_group("Target"):
		# TODO: If raycast collides with target, then level is completed.
		pass
	elif collider.is_in_group("Mirror"):
		handle_mirror_collision(raycast_collision, raycast.get_collision_normal(), idx)

func handle_mirror_collision(collision_point: Vector2, normal: Vector2, idx: int) -> void:
	line.add_point(collision_point)
	max_cast_to = max_cast_to.bounce(normal)
	if idx < lasers.size() - 1:
		lasers[idx + 1].enabled = true
		lasers[idx + 1].global_position = collision_point + max_cast_to.normalized()
	if idx == lasers.size()-1: pass
		# TODO: Add particle effect here
		# $End.global_position = raycastcollision
