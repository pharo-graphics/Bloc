instance creation - ticks
tick
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c |
			c ignoreByLayout ];
		background: Color black