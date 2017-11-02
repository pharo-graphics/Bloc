initialization
initialize
	super initialize.
	
	itemElement := BlElement new.
	itemElement layout: BlLinearLayout vertical.
	itemElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]