instance creation
matchParent
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		yourself