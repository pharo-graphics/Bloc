example - connections
lineBetweenElementBottomCenters
	<gtExample>
	| redLine fromBox toBox |
	
	fromBox := self box.
	fromBox relocate: 50@50.
	
	toBox := self box.
	toBox relocate: 250@250.
	
	redLine := self redLine.
	
	redLine fromAnchor: (BlElementBottomCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementBottomCenterAnchor element: toBox).
	
	^ self container
		addChildren: { fromBox . toBox . redLine }