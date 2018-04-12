accessing
right: aTextSelectionNode
	self
		assert: [ aTextSelectionNode isNotNil ]
		description: [ 'aTextSelectionNode must not be nil' ].
	
	right := aTextSelectionNode