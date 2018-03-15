api - constraints
minWidth: aNumber
	"Set minimal width to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Minimal width must not be nil' ].
		
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Minimal width must not be infinite' ].
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Minimal width must be non-negative' ].
		
	minWidth := aNumber