examples - instance creation
scrollContent
	<gtExample>
	
	^ BlElement new
		background: (Color blue alpha: 0.2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 1000 ]