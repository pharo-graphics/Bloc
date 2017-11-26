instance creation - hand
secondHand
	<gtExample>
	| handStart handDot handLine |
	
	handStart := self handStart.
	handStart relocate: (self secondHandLength - self handOffset - self handOffset) @ 0.
	
	handDot := self handDot.
	
	handLine := self handLine.
	handLine fromAnchor: (BlElementCenterAnchor element: handStart).
	handLine toAnchor: (BlElementCenterAnchor element: handDot).
	
	^ self hand
		constraintsDo: [ :c |
			c horizontal exact: (self secondHandLength - self handOffset) * 2.
			c vertical fitContent ];
		addChildren: { handStart . handDot . handLine };
		yourself