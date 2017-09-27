initialization
initialize
	super initialize.
	
	itemElement := BlElement new.
	itemElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	itemElement background: Color random.