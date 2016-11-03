accessing
borderPathOn: aCanvas
	^ borderPath ifNil: [ borderPath := self pathOn: aCanvas inBounds: self borderBounds ]