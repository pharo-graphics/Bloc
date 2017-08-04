accessing
root
	<return: #BlTextSelectionNode>
	
	self
		assert: [ root isNotNil ]
		description: [ 'Root can not be nil' ].
	
	^ root