adding
withAll: aCollectionOfBackgrounds
	self
		assert: [ aCollectionOfBackgrounds isNotNil ]
		description: [ 'Collection must not be nil' ].
	self
		assert: [ aCollectionOfBackgrounds allSatisfy: #isNotNil ]
		description: [ 'All backgrounds must not be nil' ].
	self
		assert: [ aCollectionOfBackgrounds isNotEmpty ]
		description: [ 'Collection of background must not be empty' ].

	backgrounds := aCollectionOfBackgrounds asArray copy