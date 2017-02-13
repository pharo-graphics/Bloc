adding
addSpace: aSpace

	self
		assert: [ (spaces includes: aSpace) not ]
		description: [ 'Can not add space that is already managed!' ].

	spaces := spaces copyWith: aSpace