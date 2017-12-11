accessing
paint: aBlPaint
	self
		assert: [ aBlPaint isNotNil ]
		description: [ 'Paint must not be nil' ].

	self
		assert: [ paint isNil ]
		description: [ 'Background is immutable and can not be changed' ].

	paint := aBlPaint asBlPaint