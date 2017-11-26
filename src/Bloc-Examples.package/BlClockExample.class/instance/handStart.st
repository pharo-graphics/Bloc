instance creation - hand
handStart
	<gtExample>

	^ BlElement new
		size: 0@0;
		constraintsDo: [ :c | c frame vertical alignCenter ]