private- host space
unregisterHostSpace: aWindowID
	self
		assert: [ hostSpaces includesKey: aWindowID ]
		description: [ 'Host space with id: ', aWindowID asString, ' is not registered' ].

	hostSpaces removeKey: aWindowID