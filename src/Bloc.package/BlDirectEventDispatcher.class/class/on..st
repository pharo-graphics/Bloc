instance creation
on: aTBlEventTarget
	<return: #BlDirectEventDispatcher>

	self
		assert: [ aTBlEventTarget isNotNil ]
		description: [ 'Event target must not be nil' ].

	^ self basicNew
		initialize;
		owner: aTBlEventTarget;
		yourself