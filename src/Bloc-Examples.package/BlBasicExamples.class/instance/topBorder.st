examples - border
topBorder
	<gtExample>

	^ self horizontalBorder
		constraintsDo: [ :c |
			c frame vertical alignTop ]