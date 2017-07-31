invalidation
invalidateBoundsInSpace

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.
	transformedBounds := nil.
	boundsInParent := nil.

	self owner children do: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]