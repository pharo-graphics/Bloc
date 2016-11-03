accessing
extent
	self hostSpace ifNotNil: [ :hw | ^ hw extent ].
	^ extent