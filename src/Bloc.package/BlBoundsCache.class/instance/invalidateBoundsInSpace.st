invalidation
invalidateBoundsInSpace

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.

	self owner children do: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]