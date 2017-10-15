I represent an abstract dimension-less vector.
My subclasses implement API for concrete spaces (2D, 3D, etc).

I define basic vector function such as:
	- length
	- negated
	- normalized
	
Instance creation examples:

Create a 2D vector:

	BlVector x: 10 y: 20
	or
	(10, 20)
	
Create a 3D vector:

	BlVector x: 10 y: 20 z: 30
	or
	(10, 20, 30)