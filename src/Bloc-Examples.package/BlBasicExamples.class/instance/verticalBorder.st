examples - border
verticalBorder
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 20.
			c vertical matchParent ]