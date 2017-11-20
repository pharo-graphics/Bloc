examples - border
leftBorder
	<gtExample>

	^ self verticalBorder
		constraintsDo: [ :c |
			c frame horizontal alignLeft ]