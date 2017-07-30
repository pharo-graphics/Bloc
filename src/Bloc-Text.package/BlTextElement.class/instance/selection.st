selection - management
selection
	<return: #Interval>
	
	self
		assert: [ selection isNotNil ]
		description: [ 'Selection interval can not be nil' ].

	^ selection