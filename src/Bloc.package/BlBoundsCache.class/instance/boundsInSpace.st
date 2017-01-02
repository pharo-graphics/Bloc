accessing
boundsInSpace
	^ boundsInSpace ifNil: [ boundsInSpace := self owner localBoundsToGlobal: self boundsInLocal ]