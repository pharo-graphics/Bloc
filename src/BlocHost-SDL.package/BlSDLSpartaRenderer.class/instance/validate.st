development support
validate
	self checkSession.
	(texture isNil or: [ texture isNull ]) ifTrue: [ ^ false ].	
	sdlSpace rendererExtent ~= textureExtent ifTrue: [ ^ false ].
	^ true