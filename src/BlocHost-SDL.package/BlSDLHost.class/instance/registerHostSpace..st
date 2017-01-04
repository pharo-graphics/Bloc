private - host space
registerHostSpace: aBlSDLSpace

	self
		assert: [ aBlSDLSpace isNotNil ]
		description: [ 'Host space must not be nil' ].
	
	self
		assert: [ (hostSpaces includesKey: aBlSDLSpace windowID) not ]
		description: [ 'Host space with id: ', aBlSDLSpace windowID asString, ' is already registered' ].

	hostSpaces
		at: aBlSDLSpace windowID
		put: aBlSDLSpace