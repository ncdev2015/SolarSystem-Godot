extends Node2D

func _ready():
	pass

func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		# Run only once per press
		if event.pressed and event.scancode == KEY_SPACE and not event.echo:
			print("space pressed")
