private - accessing
next
	<return: #BlEventDispatcherChain>
	
	self
		assert: [ self hasNext ]
		description: [ 'Can not access next element in a chain if it does not exist' ].
	
	^ next