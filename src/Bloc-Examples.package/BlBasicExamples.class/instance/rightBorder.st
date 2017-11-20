examples - border
rightBorder
	<gtExample>
	
	^ self verticalBorder
		constraintsDo: [ :c |
			c frame horizontal alignRight ]