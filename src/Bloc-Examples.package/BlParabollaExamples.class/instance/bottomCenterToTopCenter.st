examples - self edges
bottomCenterToTopCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }