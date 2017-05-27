private
type: aType lineJoin: aLineJoin lineCap: aLineCap miterLimit: aMiterLimit dashOffset: aNumber dashArray: anArray

	self
		assert: [ anArray isNotNil ]
		description: [ 'Dash pattern array must not be nil' ].

	type := aType.
	lineJoin := aLineJoin.
	lineCap := aLineCap.
	miterLimit := aMiterLimit.
	dashOffset := aNumber.
	dashArray := anArray