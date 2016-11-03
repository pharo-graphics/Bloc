accessing properties
positionProperty
	^ position
		ifNil: [ position := BlObjectProperty on: self named: #position default: 0 @ 0 ]