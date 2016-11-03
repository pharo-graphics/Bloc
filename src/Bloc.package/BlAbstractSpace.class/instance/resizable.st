accessing
resizable
	self hostSpace ifNotNil: [ :hw | ^ hw resizable ].
	^ resizable