*Bloc-Sparta
geomPathOnSpartaCanvas: aCanvas
	self checkSession.
	^ geomPath ifNil: [ geomPath := self pathOnSpartaCanvas: aCanvas inBounds: self owner boundsInLocal ]