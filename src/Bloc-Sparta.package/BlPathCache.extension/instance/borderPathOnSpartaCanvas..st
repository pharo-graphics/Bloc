*Bloc-Sparta
borderPathOnSpartaCanvas: aCanvas

	^ borderPath ifNil: [ borderPath := self pathOnSpartaCanvas: aCanvas inBounds: self borderBounds ]