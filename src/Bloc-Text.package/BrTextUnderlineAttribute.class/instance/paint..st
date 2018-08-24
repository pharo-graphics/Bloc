accessing
paint: aPaint
	self 
		assert: [ aPaint notNil ] 
		description: [ 'Paint must be non-nil' ].
	paint := aPaint asBlPaint