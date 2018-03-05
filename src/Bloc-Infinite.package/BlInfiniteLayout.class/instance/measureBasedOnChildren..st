measurement
measureBasedOnChildren: anExtentSpec
	"Measures infinite element based on children' bounding box.
	Custom infinite layouts may want to override me to handle
	bounding box calculation differently"
	| minX minY maxX maxY |
	
	self hasChildren
		ifFalse: [ ^ self defaultMeasure: infiniteElement with: anExtentSpec ].

	minX := Float infinity.
	minY := Float infinity.
	maxX := Float negativeInfinity.
	maxY := Float negativeInfinity.
	
	self childrenDo: [ :aChildElement |
		| aChildBounds |
		aChildBounds := self decoratedBoundsWithMargins: aChildElement.

		minX := minX min: aChildBounds left.
		maxX := maxX max: aChildBounds right.
		minY := minY min: aChildBounds top.
		maxY := maxY max: aChildBounds bottom ].
	
	self
		measuredBoundingBox: ((minX @ minY) corner: (maxX @ maxY))
		with: anExtentSpec