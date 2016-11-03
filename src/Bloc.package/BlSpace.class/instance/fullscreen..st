accessing
fullscreen: aBoolean
	fullscreen := aBoolean.
	 self hostSpace ifNotNil: [ :hw | hw fullscreen: aBoolean ].