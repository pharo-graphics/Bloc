initialization
initialize
	super initialize.
	
	isFinished := true.
	physicalCoefficient := GravityEarth
		* 39.37 "inch/meter"
		* 96.0  "ppi"
		* 0.84. "look and feel tuning"