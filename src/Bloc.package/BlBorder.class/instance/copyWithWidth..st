copy
copyWithWidth: aWidth

	self
		assert: [ aWidth isNotNil ]
		description: [ 'Width must not be nil' ].

	^ self class new
		paint: paint;
		style: style;
		width: aWidth;
		yourself