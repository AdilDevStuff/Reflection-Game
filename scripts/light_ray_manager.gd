extends Node2D

@export var max_bounces: int = 3

@export var line: Line2D
@export var ray_origin: Marker2D
@export var raycast: RayCast2D

@onready var light_source: CharacterBody2D = $LightSource

var points: Array = []

func _process(_delta):
	calculate_light_path()

func calculate_light_path():
	points = [ray_origin.global_position]
	
	var start = ray_origin.global_position
	# wth bro legit go RIGHT
	# var direction = Vector2.RIGHT.rotated(rotation)
	# so real
	var direction : Vector2 = light_source.position.direction_to(ray_origin.position)
	
	for _i in range(max_bounces):
		var result = cast_ray(start, direction)
		
		if result:
			var collision_point = result.position
			var collider = result.collider
			var normal = result.normal
			
			points.append(collision_point)
			
			if collider.is_in_group("Mirror"):
				# print("%.2f" % direction.dot(normal))
				
				#if direction.dot(normal) > 0:
					#break  
				
				direction = direction.bounce(normal)
				start = collision_point + direction * 1
			
			## TODO: FIX THIS idk what to do ;C
			elif collider.is_in_group("LightRepeater"):
				# how do i make light repeat ?-?
				# restart the loop ??
				print("Repeat light")
				
			# so many elifs, we are not elves
			elif collider.is_in_group("LightSensor"):
				if collider.has_method("on_light_fall"):
					collider.on_light_fall()
			else:
				# Collider is blocking
				break
		else:
			points.append(start + direction * 2000)
			break
	
	update_line(points)


func cast_ray(start: Vector2, direction: Vector2):
	raycast.global_position = start
	raycast.target_position = direction * 2000
	raycast.force_raycast_update()

	if raycast.is_colliding():
		return {
			"position": raycast.get_collision_point(),
			"normal": raycast.get_collision_normal(),
			"collider": raycast.get_collider()
		}
	
	return null

func update_line(points: Array):
	line.clear_points()
	for point in points:
		line.add_point(to_local(point))
