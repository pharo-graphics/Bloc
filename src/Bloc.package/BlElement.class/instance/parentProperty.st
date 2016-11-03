accessing properties
parentProperty
	^ parent ifNil: [ parent := BlObjectProperty on: self named: #parent ]