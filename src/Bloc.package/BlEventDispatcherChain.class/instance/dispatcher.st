private - accessing
dispatcher
	<return: #BlEventDispatcher>

	self
		assert: [ dispatcher isNotNil ]
		description: [ 'Dispatcher must not be nil' ].
	
	^ dispatcher