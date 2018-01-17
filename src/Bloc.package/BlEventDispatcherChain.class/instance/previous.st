private - accessing
previous
	<return: #BlEventDispatcherChain>
	
	self
		assert: [ self hasPrevious ]
		description: [ 'Can not access previous element in a chain if it does not exist' ].
	
	^ previous