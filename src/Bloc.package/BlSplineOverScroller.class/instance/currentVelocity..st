private - accessing
currentVelocity: aNumber
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Velocity can not be nil!' ].
	
	currentVelocity := aNumber