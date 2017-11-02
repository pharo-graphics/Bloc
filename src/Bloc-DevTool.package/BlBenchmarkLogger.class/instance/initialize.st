initialization
initialize
	super initialize.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self border: (BlBorder paint: Color red width: 2).
	
	self wantsMouse: false