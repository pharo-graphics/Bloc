private- host space
registerHostSpace: anHostSpace
	
	self
		assert: [ anHostSpace isNotNil ]
		description: [ 'Host space must not be nil' ].
	
	self
		assert: [ (hostSpaces includesKey: anHostSpace windowID) not ]
		description: [ 'Host space with id: ', anHostSpace windowID asString, ' is already registered' ].

	hostSpaces
		at: anHostSpace windowID 
		put: anHostSpace