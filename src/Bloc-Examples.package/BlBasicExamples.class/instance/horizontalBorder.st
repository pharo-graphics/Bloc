examples - border
horizontalBorder
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: 20.
			c horizontal matchParent ]