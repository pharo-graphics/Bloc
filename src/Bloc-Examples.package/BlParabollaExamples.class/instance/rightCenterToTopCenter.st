examples - self edges
rightCenterToTopCenter
	<gtExample>
	| aCurve anElement |
	
	anElement := self referenceElement.
	
	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container addChildren: { anElement . aCurve }