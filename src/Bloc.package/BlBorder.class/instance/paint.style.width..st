initialization
paint: aPaint style: aStrokeStyle width: aNumber

	self
		assert: [ aPaint isNotNil ]
		description: [ 'Paint must not be nil' ].

	self
		assert: [ aStrokeStyle isNotNil ]
		description: [ 'Stroke style must not be nil' ].
		
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Width must not be nil' ].
		
	paint := aPaint.
	style := aStrokeStyle.
	width := aNumber asFloat