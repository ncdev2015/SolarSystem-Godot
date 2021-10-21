extends Node2D

var planets: Array
var distance = 10

var mercury = preload("res://planets/mercury.tscn")
var venus = preload("res://planets/venus.tscn")
var earth = preload("res://planets/earth.tscn")
var mars = preload("res://planets/mars.tscn")
var jupiter = preload("res://planets/jupiter.tscn")
var saturn = preload("res://planets/saturn.tscn")
var neptune = preload("res://planets/neptune.tscn")
var uranus = preload("res://planets/uranus.tscn")

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

func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		# Run only once per press
		if event.pressed and event.scancode == KEY_SPACE and not event.echo:
			var next_planet = get_next_planet()
			if next_planet:
				add_planet_to_scene(next_planet) 
			
func get_next_planet():
	return planets.pop_front()

func add_planet_to_scene(planet):
	add_child(planet.instance())
