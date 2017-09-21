*Bloc-Sparta
geomPathOnSpartaCanvas: aCanvas
	self checkSession.
	^ geometryPath ifNil: [ geometryPath := self pathOnSpartaCanvas: aCanvas inBounds: self ownerElement boundsInLocal ]