initialization
initializeWith: aTBlScrollable

	self
		assert: [ aTBlScrollable isNotNil ]
		description: [ 'Scrollable must not be nil' ].

	self
		assert: [ scrollable isNil ]
		description: [ 'I can be initialized only once!' ].

	scrollable := aTBlScrollable