as yet unclassified
invalidateBoundsInSpace
	boundsInSpace := layoutBoundsInSpace := geomBoundsInSpace := nil.
	self owner children do:[:c| c boundsCache invalidateBoundsInSpace]