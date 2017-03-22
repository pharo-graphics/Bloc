transformation - accessing
inverseTransformation
	"Return my current inverse transformation.
	If transformation does not exist, message sent results in undefined behaviour"
	<return: #BlTransformation>
	
	self
		assert: [ inverseTransformation isNotNil ]
		description: [ 'Inverse transformation must exist! (use #hasTransformation before)' ].
	
	^ inverseTransformation