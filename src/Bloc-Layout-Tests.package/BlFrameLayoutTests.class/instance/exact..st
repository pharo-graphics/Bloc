instance creation
exact: aPoint
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself