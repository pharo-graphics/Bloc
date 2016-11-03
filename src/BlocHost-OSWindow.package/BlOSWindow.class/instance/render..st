drawing
render: aStage
	self isValid
		ifFalse: [ ^ self ].
	^ renderer render: aStage