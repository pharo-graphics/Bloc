as yet unclassified
validate
	self checkSession.
	(texture isNil or: [ texture isNull ]) ifTrue: [ ^ false ].	
	sdlSpace extent ~= textureExtent ifTrue: [ ^ false ].
	^ true