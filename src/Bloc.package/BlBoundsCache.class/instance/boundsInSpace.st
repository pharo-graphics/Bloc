as yet unclassified
boundsInSpace
	^ boundsInSpace ifNil: [ boundsInSpace := self owner localBoundsToGlobal: self boundsInLocal ]
	