accessing
image: aForm
	self
		assert: [ aForm isNotNil ]
		description: [ 'Image must not be nil' ].

	self
		assert: [ image isNil ]
		description: [ 'Background is immutable and can not be changed' ].
		
	image := aForm.
	bitmap := nil