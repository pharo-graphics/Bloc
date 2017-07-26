accessing
action: anObject
	self
		assert: [ anObject isNotNil ]
		description: [ 'Action must not be nil' ].

	action := anObject