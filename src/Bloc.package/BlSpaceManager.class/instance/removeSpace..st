adding
removeSpace: aSpace

	self
		assert: [ spaces includes: aSpace ]
		description: [ 'Can not remove space that is not managed!' ].

	spaces := spaces copyWithout: aSpace