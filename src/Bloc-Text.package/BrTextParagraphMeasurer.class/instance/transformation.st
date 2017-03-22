transformation - accessing
transformation
	"Return my current transformation.
	If transformation does not exist, message sent results in undefined behaviour"
	<return: #BlTransformation>
	
	self
		assert: [ transformation isNotNil ]
		description: [ 'Transformation must exist! (use #hasTransformation before)' ].
	
	^ transformation