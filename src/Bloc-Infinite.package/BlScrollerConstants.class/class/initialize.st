initialization
initialize
	super initialize.
	
	DecelerationRate := 0.78 log / 0.9 log.
	Gravity := 2000.0.
	GravityEarth := 9.80665.
	ScrollFriction := 0.015.
	Inflexion := 0.35.
	StartTension := 0.5.
	EndTension := 1.0.
	P1 := StartTension * Inflexion.
	P2 := 1.0 - (EndTension * (1.0 - Inflexion)).
	NbSamples := 100.
	SplinePosition := Array new: NbSamples + 1.
	SplineTime := Array new: NbSamples + 1.

	Spline := 1.
	Cubic := 2.
	Ballistic := 3.
	
	self initializeSplines