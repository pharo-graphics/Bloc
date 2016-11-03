accessing properties
fromProperty
	^ from ifNil: [ from := BlLinePointProperty on: self named: #from default: 0@0]