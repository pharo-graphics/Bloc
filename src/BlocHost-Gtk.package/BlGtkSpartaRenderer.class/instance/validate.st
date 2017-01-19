initialization
validate
	self checkSession.
	hostSpace windowExtent ~= extent ifTrue: [ ^ false ].
	^ true