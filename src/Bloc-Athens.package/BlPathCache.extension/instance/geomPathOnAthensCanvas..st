*Bloc-Athens
geomPathOnAthensCanvas: aCanvas
	^ geomPath ifNil: [ geomPath := self pathOnAthensCanvas: aCanvas inBounds: self owner geomBounds ]