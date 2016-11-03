as yet unclassified
geomBoundsInSpace
	^ geomBoundsInSpace
		ifNil: [ geomBoundsInSpace := (self owner localBoundsToGlobal: self owner  geomBounds)  ]