accessing
resizable: aBoolean
	resizable := aBoolean.
	self hostSpace ifNotNil: [ :hw | hw resizable: aBoolean ]