*Bloc-Sparta
pathOnSpartaCanvas: aCanvas
	self checkSession.
	self checkIdentity: aCanvas.

	^ geometryPath ifNil: [
		canvasIdentity := aCanvas identity.
		geometryPath := self geometry buildPathOnSpartaCanvas: aCanvas ]