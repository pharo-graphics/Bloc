private - updating resources
validate
	self checkSession.
	hostSpace windowExtent ~= extent ifTrue: [ ^ false ].
	^ true