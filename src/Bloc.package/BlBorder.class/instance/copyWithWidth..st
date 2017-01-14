copy
copyWithWidth: aWidth

	self
		assert: [ aWidth isNotNil ]
		description: [ 'Width must not be nil' ].

	^ self class basicNew
		initialize;
		paint: paint
		style: style
		width: aWidth;
		yourself