as yet unclassified
invalidateBoundsInSpace
	boundsInSpace ifNil: [ ^ self ].

	boundsInSpace := nil.
	geomBoundsInSpace := nil.
	
	self owner children do: [ :c | c boundsCache invalidateBoundsInSpace ]