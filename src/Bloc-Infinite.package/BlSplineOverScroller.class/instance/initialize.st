initialization
initialize
	super initialize.
	
	isFinished := true.
	currentVelocity := 0.
	flingFriction := 0.015.
	physicalCoefficient := GravityEarth
		* 39.37 "inch/meter"
		* 96.0  "ppi"
		* 0.84. "look and feel tuning"