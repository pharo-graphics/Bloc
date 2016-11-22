accessing
dataSourcePosition
	^ infiniteElement
		ifNil: [ BlInfiniteElement noPosition ]
		ifNotNil: [ :ctx | ctx dataSourcePositionOf: self ]