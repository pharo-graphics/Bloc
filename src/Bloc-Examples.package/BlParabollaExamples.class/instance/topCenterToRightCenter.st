examples - self edges
topCenterToRightCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }