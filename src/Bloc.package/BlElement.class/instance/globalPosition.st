geometry position
globalPosition
	self parent ifNil: [ ^ self position ].
	^ self parent localPointToGlobal: self position