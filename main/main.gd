extends Node2D

var planets: Array
var positions: Array

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
	
	positions = [
		$Positions/MercuryPosition,
		$Positions/VenusPosition,
		$Positions/EarthPosition,
		$Positions/MarsPosition,
		$Positions/JupiterPosition,
		$Positions/SaturnPosition,
		$Positions/NeptunePosition,
		$Positions/UranusPosition
	]

func _process(delta):
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
