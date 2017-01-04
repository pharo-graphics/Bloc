initialization
initialize
	super initialize.
	self background: self createGradientPaint.
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]