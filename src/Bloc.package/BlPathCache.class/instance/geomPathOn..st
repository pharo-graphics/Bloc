accessing
geomPathOn: aCanvas
	^ geomPath ifNil: [ geomPath := self pathOn: aCanvas inBounds: self owner geomBounds ]