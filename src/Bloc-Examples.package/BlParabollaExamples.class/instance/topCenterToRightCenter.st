examples - self edges
topCenterToRightCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterTopAnchor element: anElement).
	aCurve toAnchor: (BlElementRightCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }