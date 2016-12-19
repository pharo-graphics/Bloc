initialization
initialize
	super initialize.

	itemElement := BlInfiniteExampleControlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40 ];
		yourself