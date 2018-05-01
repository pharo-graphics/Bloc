examples - self edges
bottomCenterToTopCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterBottomAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterTopAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }