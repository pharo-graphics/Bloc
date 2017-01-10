invalidation
invalidateBoundsInSpace

	boundsInSpace
		ifNil: [ ^ self ].

	boundsInSpace := nil.
	geometryBoundsInSpace := nil.

	self owner children do: [ :anElement |
		anElement boundsCache invalidateBoundsInSpace ]