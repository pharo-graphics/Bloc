focus managing
requestFocusFor: anElement
	self
		assert: [ anElement space = self ]
		description: [ 'anElement must be attached to the scenegraph own by this space' ].
		
	self focusProcessor requestFor: anElement