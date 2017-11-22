initialization
initialize
	super initialize.

	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40.
			c margin: (BlInsets bottom: 3) ];
		yourself