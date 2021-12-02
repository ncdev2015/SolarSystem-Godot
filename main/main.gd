extends Node2D

# Global variables
var planets: Array
var positions: Array
var planets_in_scene: Array

# Import scenes to create instances for every planet
var mercury = preload("res://planets/mercury/mercury.tscn")
var venus = preload("res://planets/venus/venus.tscn")
var earth = preload("res://planets/earth/earth.tscn")
var mars = preload("res://planets/mars/mars.tscn")
var jupiter = preload("res://planets/jupiter/jupiter.tscn")
var saturn = preload("res://planets/saturn/saturn.tscn")
var neptune = preload("res://planets/neptune/neptune.tscn")
var uranus = preload("res://planets/uranus/uranus.tscn")

# Sun angular velocity
var sun_rotation_velocity = 0.1

# Draw a circle using the draw arc method
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 200
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

# Draw a entire circle with the Sun as a center
func draw_orbit(radius = 1000):
	draw_circle_arc($Sun.position, radius, 0, 360, Color(1.0, 0.0, 0.0))

# Returns a distance among two points
func get_distance_to( pointA, pointB ):
	return pointA.distance_to(pointB)

# Where the script starts
func _ready():
	planets = [
		{ "planet": mercury.instance(), "position": $Positions/Mercury, "angularVelocity": 100, "currentAngle": 0 },
		{ "planet": venus.instance(), "position": $Positions/Venus, "angularVelocity": 125, "currentAngle": 0 },
		{ "planet": earth.instance(), "position": $Positions/Earth, "angularVelocity": 130, "currentAngle": 0 },
		{ "planet": mars.instance(), "position": $Positions/Mars, "angularVelocity": 135, "currentAngle": 0 },
		{ "planet": jupiter.instance(), "position": $Positions/Jupiter, "angularVelocity": 140, "currentAngle": 0 },
		{ "planet": saturn.instance(), "position": $Positions/Saturn, "angularVelocity": 130, "currentAngle": 0 },
		{ "planet": neptune.instance(), "position": $Positions/Neptune, "angularVelocity": 120, "currentAngle": 0 },
		{ "planet": uranus.instance(), "position": $Positions/Uranus, "angularVelocity": 100, "currentAngle": 0 }
	]

# Main loop
func _process(delta):
	$Sun.rotate(delta * sun_rotation_velocity)	

	# Update angular position of each planet
	for planet in planets_in_scene:

		var r = planet.distanceToCenter

		planet.currentTime += delta

		planet.position.x = r * cos(deg2rad( planet.angularVelocity * planet.currentTime)) + $Sun.position.x
		planet.position.y = -r * sin(deg2rad( planet.angularVelocity * planet.currentTime)) + $Sun.position.y

	update() # for update canvas every frame

# Manages key inputs
func _unhandled_input(event):
	if event is InputEventKey and event.pressed:		
		if event.scancode == KEY_SPACE and not event.echo:
			add_planet_to_scene(get_next_planet())

		if event.scancode == KEY_ESCAPE:
			get_tree().quit()

# Necessary to draw primitives (arcs, circles, lines etc) on the canvas
func _draw():
	for p in planets_in_scene:
		draw_orbit(get_distance_to(p.position, $Sun.position))

# Returns the next planet from a list of planets
func get_next_planet():
	return planets.pop_front()

# Return a planet to add in the scene
func initializePlanet(planetObj):
	var instance = planetObj["planet"]
	
	instance.scale = Vector2(.1, .1) # Default scale
	instance.position = planetObj["position"].position
	instance.angularVelocity = planetObj["angularVelocity"]
	instance.distanceToCenter = get_distance_to(instance.position, $Sun.position)

	return instance

func addPlanetToScene(planetInstance):
	planets_in_scene.append(planetInstance)
	add_child(planetInstance)

# Add a new planet and instances it from a list of planets
func add_planet_to_scene(planetObj):
	if (not planetObj):
		return
	
	addPlanetToScene(initializePlanet(planetObj))	
