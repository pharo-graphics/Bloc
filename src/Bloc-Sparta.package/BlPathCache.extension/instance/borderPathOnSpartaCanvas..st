*Bloc-Sparta
borderPathOnSpartaCanvas: aCanvas
	self checkSession.
	^ borderPath ifNil: [ borderPath := self pathOnSpartaCanvas: aCanvas inBounds: self borderBounds ]