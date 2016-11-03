accessing
maxWidth: aNumber
	"Set maximal width to be aNumber,
	aNumber must not be nil
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Maximal width must not be nil' ].
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Maximal width must be non-negative' ].
	
	maxWidth := aNumber