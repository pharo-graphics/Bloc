examples - self edges
rightCenterToTopCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementRightCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterTopAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }