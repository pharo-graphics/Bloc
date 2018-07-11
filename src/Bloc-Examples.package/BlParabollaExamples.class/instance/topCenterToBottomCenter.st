examples - self edges
topCenterToBottomCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementBottomCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }