initialization
initialize
	super initialize.

	itemElement := BlElement new
		layout: BlFlowLayout new horizontal;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		yourself