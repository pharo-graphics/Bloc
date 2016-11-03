accessing
position
	self hostSpace ifNotNil: [ :hw | ^ hw position ].
	^ position