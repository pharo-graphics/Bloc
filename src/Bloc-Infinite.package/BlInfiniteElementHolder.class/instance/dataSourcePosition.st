accessing
dataSourcePosition
	^ context
		ifNil: [ BlInfiniteElement noPosition ]
		ifNotNil: [ :ctx | ctx dataSourcePositionOf: self ]