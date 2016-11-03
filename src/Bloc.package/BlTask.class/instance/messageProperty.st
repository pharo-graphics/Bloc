accessing properties
messageProperty
	^ message ifNil: [ message := BlObjectProperty on: self named: #message default: '' ]