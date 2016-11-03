accessing
fullscreen
	self hostSpace ifNotNil: [ :hw | ^ hw fullscreen ].
	^ fullscreen