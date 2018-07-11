examples - self edges
bottomToTopBidirectional
	<gtExample>
	| aCurveDown aCurveUp anElement |
	
	anElement := self referenceElement.
	
	aCurveDown := self blueArcWithToHead.
	aCurveDown fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurveDown toAnchor: (BlElementBottomCenterAnchor element: anElement).
	
	aCurveUp := self redArcWithToHead.
	aCurveUp fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurveUp toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveDown . aCurveUp }