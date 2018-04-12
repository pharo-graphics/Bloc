accessing
left
	self
		assert: [ left isNotNil ]
		description: [ 'You can not access `left` if it does not exist. Check #hasLeft first!' ].
	
	^ left