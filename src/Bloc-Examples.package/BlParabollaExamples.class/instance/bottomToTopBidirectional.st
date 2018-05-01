examples - self edges
bottomToTopBidirectional
	<gtExample>
	| aCurveDown aCurveUp anElement |
	
	anElement := self referenceElement.
	
	aCurveDown := self blueArcWithToHead.
	aCurveDown fromAnchor: (BlElementCenterTopAnchor element: anElement).
	aCurveDown toAnchor: (BlElementCenterBottomAnchor element: anElement).
	
	aCurveUp := self redArcWithToHead.
	aCurveUp fromAnchor: (BlElementCenterBottomAnchor element: anElement).
	aCurveUp toAnchor: (BlElementCenterTopAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveDown . aCurveUp }