accessing properties
hostWindowProperty
	^ hostWindow ifNil: [ hostWindow := BlObjectProperty on: self named: #hostWindow ]