accessing
borderFraction: aNumber
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Border fraction must not be nil' ].

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Bordern fraction must not be negative' ].

	borderFraction := aNumber.
	self geometryChanged