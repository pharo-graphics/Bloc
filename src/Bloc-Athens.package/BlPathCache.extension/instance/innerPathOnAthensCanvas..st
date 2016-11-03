*Bloc-Athens
innerPathOnAthensCanvas: aCanvas
	^ innerPath ifNil: [ innerPath := self pathOnAthensCanvas: aCanvas inBounds: self owner innerBounds ]