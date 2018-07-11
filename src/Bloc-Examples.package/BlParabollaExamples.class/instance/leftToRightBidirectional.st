examples - self edges
leftToRightBidirectional
	<gtExample>
	| aCurveLeft aCurveRight anElement |
	
	anElement := self referenceElement.
	
	aCurveLeft := self redArcWithToHead.
	aCurveLeft fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurveLeft toAnchor: (BlElementCenterLeftAnchor element: anElement).
	
	aCurveRight := self blueArcWithToHead.
	aCurveRight fromAnchor: (BlElementCenterLeftAnchor element: anElement).
	aCurveRight toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container addChildren: { anElement . aCurveLeft . aCurveRight }