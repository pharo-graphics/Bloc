geometry position
globalPosition
	self parent ifNil: [ ^ self position ].
	^ self parent globalPosition translateBy: self position