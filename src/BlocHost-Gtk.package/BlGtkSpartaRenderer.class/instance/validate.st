initialization
validate
	self checkSession.
	hostSpace extent ~= textureExtent ifTrue: [ ^ false ].
	^ true