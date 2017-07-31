selection - management
selection
	<return: #BlTextSelection>
	
	self
		assert: [ selection isNotNil ]
		description: [ 'Selection can not be nil' ].

	^ selection