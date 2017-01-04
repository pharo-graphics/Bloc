as yet unclassified
geomBoundsInSpace
	^ geomBoundsInSpace
		ifNil: [ geomBoundsInSpace := (self owner geomBoundsInSpace: SpartaRectangle new) asRectangle ]