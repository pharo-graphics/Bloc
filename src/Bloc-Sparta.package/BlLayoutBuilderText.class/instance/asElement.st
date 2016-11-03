converting
asElement
	^ BlElement new
		extent: 50@50;
		background: Color random lighter;
		constraintsDo: [ :c | 
			c vertical exact: 70.
			c horizontal matchParent ];
		yourself