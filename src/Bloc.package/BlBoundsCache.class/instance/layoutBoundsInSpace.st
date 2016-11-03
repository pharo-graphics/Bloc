as yet unclassified
layoutBoundsInSpace
	^ layoutBoundsInSpace
		ifNil: [ layoutBoundsInSpace := (self owner localBoundsToGlobal: self owner  layoutBounds)  ]