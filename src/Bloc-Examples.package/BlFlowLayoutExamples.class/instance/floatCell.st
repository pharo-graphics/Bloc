instance creation
floatCell
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ]