accessing properties
progressProperty
	^ progress ifNil: [ progress := BlObjectProperty on: self named: #progress default: 0 ]