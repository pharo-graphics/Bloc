accessing
left: aTextSelectionNode
	self
		assert: [ aTextSelectionNode isNotNil ]
		description: [ 'aTextSelectionNode must not be nil' ].
	
	left := aTextSelectionNode