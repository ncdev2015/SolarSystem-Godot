extends Node2D

var planets: Array
var positions: Array
var planets_in_scene: Array

var mercury = preload("res://planets/mercury.tscn")
var venus = preload("res://planets/venus.tscn")
var earth = preload("res://planets/earth.tscn")
var mars = preload("res://planets/mars.tscn")
var jupiter = preload("res://planets/jupiter.tscn")
var saturn = preload("res://planets/saturn.tscn")
var neptune = preload("res://planets/neptune.tscn")
var uranus = preload("res://planets/uranus.tscn")

var sun_rotation_velocity = 0.1

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 200
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func draw_orbit(radius = 1000):
	draw_circle_arc($Sun.position, radius, 0, 360, Color(1.0, 0.0, 0.0))

func get_distance_to( pointA, pointB ):
	return pointA.distance_to(pointB)

func _ready():
	planets = [
		{ "planet": mercury, "position": $Postions/Mercury },
		{ "planet": venus, "position": $Postions/Venus },
		{ "planet": earth, "position": $Postions/Earth },
		{ "planet": mars, "position": $Postions/Mars },
		{ "planet": jupiter, "position": $Postions/Jupiter },
		{ "planet": saturn, "position": $Postions/Saturn },
		{ "planet": neptune, "position": $Postions/Neptune },
		{ "planet": uranus, "position": $Postions/Uranus }
	]

func _process(delta):
	$Sun.rotate(delta * sun_rotation_velocity)
	update() # for update canvas every frame

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_SPACE and not event.echo:
				var next_planet = get_next_planet()
				if next_planet["planet"]:
					add_planet_to_scene(next_planet)

			if event.scancode == KEY_ESCAPE:
				get_tree().quit()

func _draw():
	for p in planets_in_scene:
		draw_orbit(get_distance_to(p.position, $Sun.position))
		
func get_next_planet():
	return planets.pop_front()

func add_planet_to_scene(planet):
	var instance = planet["planet"].instance()

	# init planet
	instance.scale = Vector2(.1,.1)
	instance.position = planet["position"].position
	
	# add orbit
	planets_in_scene.append(instance)

	# add to scene
	add_child(instance)
