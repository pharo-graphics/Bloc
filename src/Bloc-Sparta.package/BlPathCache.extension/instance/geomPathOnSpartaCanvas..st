*Bloc-Sparta
geomPathOnSpartaCanvas: aCanvas

	^ geomPath ifNil: [ geomPath := self pathOnSpartaCanvas: aCanvas inBounds: self owner geomBounds ]