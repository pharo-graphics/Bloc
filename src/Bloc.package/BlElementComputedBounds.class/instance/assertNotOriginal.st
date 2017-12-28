asserting
assertNotOriginal
	self
		assert: [ self referenceElement bounds ~~ self ]
		description: [ 'Can not modify original reference element bounds' ]