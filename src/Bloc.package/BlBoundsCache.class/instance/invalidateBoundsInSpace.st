as yet unclassified
invalidateBoundsInSpace
	boundsInSpace ifNil:[^ self].
	boundsInSpace := layoutBoundsInSpace := geomBoundsInSpace := nil.
	self owner children do:[:c| c boundsCache invalidateBoundsInSpace]