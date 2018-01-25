api - hooks
onInstalledIn: anElement
	self
		assert: [ attachmentsCount isZero ]
		description: [ 'I must be attached to at most one element' ].
		
	attachmentsCount := attachmentsCount + 1.
	
	self relocateTo: anElement.
	self resizeTo: anElement