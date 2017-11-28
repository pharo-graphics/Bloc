example - connections
lineBetweenSubElements
	<gtExample>
	| attachFrom attachTo fromBox toBox  redLine |
	
	attachFrom := self attachPoint.
	attachFrom
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignCenter ].
		
	attachTo := self attachPoint.
	attachTo
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignBottom ].
		
	fromBox := self box.
	fromBox relocate: 50@50.
	fromBox addChild: attachFrom.
	
	toBox := self box.
	toBox relocate: 250@250.
	toBox addChild: attachTo.
	
	redLine := self redLine.
	
	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).
	
	^ self container
		addChildren: { fromBox . toBox . redLine }