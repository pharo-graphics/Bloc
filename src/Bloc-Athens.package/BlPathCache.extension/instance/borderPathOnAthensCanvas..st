*Bloc-Athens
borderPathOnAthensCanvas: aCanvas
	^ borderPath ifNil: [ borderPath := self pathOnAthensCanvas: aCanvas inBounds: self borderBounds ]