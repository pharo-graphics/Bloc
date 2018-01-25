api - hooks
onUninstalledIn: anObject
	
	self
		assert: [ attachmentsCount = 1 ]
		description: [ 'I must be attached to at most one element' ].
	
	attachmentsCount := attachmentsCount - 1