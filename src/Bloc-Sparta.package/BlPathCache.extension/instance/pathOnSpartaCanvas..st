*Bloc-Sparta
pathOnSpartaCanvas: aCanvas
	self checkSession.

	^ geometryPath ifNil: [ geometryPath := self geometry buildPathOnSpartaCanvas: aCanvas ]