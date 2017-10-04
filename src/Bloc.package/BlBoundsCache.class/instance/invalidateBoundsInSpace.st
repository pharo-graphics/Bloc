invalidation
invalidateBoundsInSpace

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.
	transformedBounds := nil.
	boundsInParent := nil.

	self owner childrenDo: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]