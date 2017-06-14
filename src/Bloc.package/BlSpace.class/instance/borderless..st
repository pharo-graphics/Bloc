accessing
borderless: aBoolean
	borderless := aBoolean.
	 self hostSpace ifNotNil: [ :hw | hw borderless: aBoolean ].