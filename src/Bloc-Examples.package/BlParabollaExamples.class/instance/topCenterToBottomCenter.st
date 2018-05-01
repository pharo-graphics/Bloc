examples - self edges
topCenterToBottomCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterTopAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterBottomAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }