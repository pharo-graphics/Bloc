instance creation
textContainer
	<gtExample>

	^ BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		clipChildren: false