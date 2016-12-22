initialization
initialize
	super initialize.

	itemElement := BlTextElement new
		background: (Color veryVeryLightGray);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		yourself