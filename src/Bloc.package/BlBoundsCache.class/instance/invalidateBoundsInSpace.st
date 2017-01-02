as yet unclassified
invalidateBoundsInSpace
	boundsInSpace ifNil: [ ^ self ].
	boundsInSpace := geomBoundsInSpace := nil.

	self owner children do: [ :c | c boundsCache invalidateBoundsInSpace ]