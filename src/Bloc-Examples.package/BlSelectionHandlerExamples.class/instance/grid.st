instance creation
grid
	<gtExample>
	
	^ BlElement new
		background: Color veryVeryLightGray;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ];
		layout: BlGridLayout vertical;
		layoutDo: [ :l | l cellSpacing: 20; rowCount: 5 ]