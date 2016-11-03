accessing
innerPathOn: aCanvas
	^ innerPath ifNil: [ innerPath := self pathOn: aCanvas inBounds: self owner innerBounds ]