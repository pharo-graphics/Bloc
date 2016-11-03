accessing properties
hostSpaceProperty
	^ hostSpace ifNil: [ hostSpace := BlObjectProperty on: self named: #hostSpace ]