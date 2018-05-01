instance creation
grid
	<gtExample>
	
	^ BlElement new
		background: Color veryVeryLightGray;
		layout: (BlOnceLayout new layout: (BlGridLayout vertical cellSpacing: 10));
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself