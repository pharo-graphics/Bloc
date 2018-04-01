api - physics
physicalCoefficient
	<return: #Number>

	^ GravityEarth
		* 39.37 "inch/meter"
		* self ppi  "ppi"
		* 0.84. "look and feel tuning"