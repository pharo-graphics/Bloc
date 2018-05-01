examples - self edges
leftToRightBidirectional
	<gtExample>
	| aCurveLeft aCurveRight anElement |
	
	anElement := self referenceElement.
	
	aCurveLeft := self redArcWithToHead.
	aCurveLeft fromAnchor: (BlElementRightCenterAnchor element: anElement).
	aCurveLeft toAnchor: (BlElementLeftCenterAnchor element: anElement).
	
	aCurveRight := self blueArcWithToHead.
	aCurveRight fromAnchor: (BlElementLeftCenterAnchor element: anElement).
	aCurveRight toAnchor: (BlElementRightCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveLeft . aCurveRight }