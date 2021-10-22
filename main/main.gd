extends Node2D

var planets: Array
var positions: Array
var planets_to_rotate: Array

var mercury = preload("res://planets/mercury.tscn")
var venus = preload("res://planets/venus.tscn")
var earth = preload("res://planets/earth.tscn")
var mars = preload("res://planets/mars.tscn")
var jupiter = preload("res://planets/jupiter.tscn")
var saturn = preload("res://planets/saturn.tscn")
var neptune = preload("res://planets/neptune.tscn")
var uranus = preload("res://planets/uranus.tscn")

var sun_rotation_velocity = 0.25

func _ready():
	planets = [
		mercury,
		venus,
		earth,
		mars,
		jupiter,
		saturn,
		neptune,
		uranus
	]
	
	positions = [
		$Planets/MercuryPosition,
		$Planets/VenusPosition,
		$Planets/EarthPosition,
		$Planets/MarsPosition,
		$Planets/JupiterPosition,
		$Planets/SaturnPosition,
		$Planets/NeptunePosition,
		$Planets/UranusPosition
	]

func _process(delta):
	$Sun.rotate(delta * sun_rotation_velocity)
	for planet in planets_to_rotate:
		# Add rotation
		pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE and not event.echo:
			var next_planet = get_next_planet()
			if next_planet["planet"]:
				add_planet_to_scene(next_planet)
			
func get_next_planet():
	return {
		"planet": planets.pop_front(),
		"position": positions.pop_front()
	}

func add_planet_to_scene(planet):
	var instance = planet["planet"].instance()
	instance.position = planet["position"].position
	instance.scale = Vector2(.1,.1)
	add_child(instance)
	
	planets_to_rotate.append(instance)
