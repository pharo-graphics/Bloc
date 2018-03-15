api - constraints
maxHeight: aNumber
	"Set maximal height to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Maximal height must not be nil' ].
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Maximal height must be non-negative' ].
	
	maxHeight := aNumber