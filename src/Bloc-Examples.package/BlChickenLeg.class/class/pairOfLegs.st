examples
pairOfLegs
	<gtExample>

	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { 
			self singleLeg margin: (BlInsets right: 5).
			self singleLeg margin: (BlInsets left: 5) }