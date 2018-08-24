accessing
style: aBlStrokeStyle
	self 
		assert: [ aBlStrokeStyle notNil ] 
		description: [ 'Stroke style must be non-nil' ].
	style := aBlStrokeStyle