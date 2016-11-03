accessing
at: aLayoutClass
	constraints
		ifNil: [ constraints := Dictionary new ].
	^ constraints
		at: aLayoutClass
		ifAbsentPut: [ aLayoutClass constraints ]