geometry extent
size: aPoint
	
	self constraintsDo: [ :c |
		c horizontal exact: aPoint x.
		c vertical exact: aPoint y ]