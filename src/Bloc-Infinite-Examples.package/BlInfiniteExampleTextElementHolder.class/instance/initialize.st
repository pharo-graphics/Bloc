initialization
initialize
	super initialize.

	itemElement := BlTextElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		yourself