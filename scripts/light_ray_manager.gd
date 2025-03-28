extends Node2D

var rot := 0.0
var max_cast_to
var bounces := 3
var lasers := []

const MAX_LENGTH := 2000

@export var line: Line2D
@export var light_ray: RayCast2D
@export var light_source: CharacterBody2D
@export var ray_origin_marker: Marker2D

func _ready():
	lasers.append(light_ray)
	for i in range(bounces):
		var raycast = light_ray.duplicate()
		raycast.enabled = false
		add_child(raycast)
		lasers.append(raycast)

	max_cast_to = Vector2(MAX_LENGTH, 0).rotated(rot)
	light_ray.target_position = max_cast_to
	line.top_level = true

func _process(_delta):
	line.clear_points()
	line.add_point(ray_origin_marker.global_position)

	max_cast_to = Vector2(MAX_LENGTH, 0).rotated(rot)

	var idx = -1
	for raycast in lasers:
		idx += 1
		var raycastcollision = raycast.get_collision_point()

		raycast.target_position = max_cast_to
		if idx == 0:
			raycast.global_position = ray_origin_marker.global_position

		if raycast.is_colliding():
			var collider = raycast.get_collider()
			# Handles Collision with Objects
			if collider.is_in_group("Target"):
				# TODO: If raycast collides with target, then level is completed.
				pass
			if collider.is_in_group("Mirror"):
				line.add_point(raycastcollision)
				max_cast_to = max_cast_to.bounce(raycast.get_collision_normal())
				if idx < lasers.size() - 1:
					lasers[idx + 1].enabled = true
					lasers[idx + 1].global_position = raycastcollision + (1 * max_cast_to.normalized())
				if idx == lasers.size() - 1: pass
		else:
			line.add_point(raycast.global_position + max_cast_to)
			break
