copy
copyWithStyle: aStrokeStyle

	self
		assert: [ aStrokeStyle isNotNil ]
		description: [ 'Style must not be nil' ].

	^ self class new
		paint: paint;
		style: aStrokeStyle;
		width: width;
		opacity: opacity;
		yourself