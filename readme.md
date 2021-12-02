# Solar System in Godot

Example to view how to add elements in a position and animate them with GDScript code:

In this project we make a Solar System with orbitals and spin velocities around the Sun.

First image:

![Solar System](https://github.com/ncdev2015/CircularPositioningOfElements/blob/master/assets/example_1.png)

To add a planet press space key, It adds a new planet to scene with a orbit.

![Solar System](https://github.com/ncdev2015/CircularPositioningOfElements/blob/master/assets/example_2.png)

And the planets start moving:

![Solar System](https://github.com/ncdev2015/CircularPositioningOfElements/blob/master/assets/updated.png)

Funcionalities:
- Pressing the SPACE key adds a new planet
- Each planet orbits the Sun
- To set the angular velocities, go to the array of planets in the _ready() function and modify them