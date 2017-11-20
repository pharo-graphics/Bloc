examples - border
bottomBorder
	<gtExample>

	^ self horizontalBorder
		constraintsDo: [ :c |
			c frame vertical alignBottom ]