private - accessing
currentPosition: aNumber
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Position can not be nil!' ].
	
	currentPosition := aNumber