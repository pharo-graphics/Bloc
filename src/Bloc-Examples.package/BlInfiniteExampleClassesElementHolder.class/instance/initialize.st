initialization
initialize
	super initialize.

	itemElement := BlTextElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 19.
			c padding: (BlInsets left: 15) ];
		yourself