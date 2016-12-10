initialization
initialize
	super initialize.
	
	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 10 ]