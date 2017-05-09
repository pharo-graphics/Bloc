invalidation
invalidateBoundsInSpace

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.
	transformedBounds := nil.

	self owner children do: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]