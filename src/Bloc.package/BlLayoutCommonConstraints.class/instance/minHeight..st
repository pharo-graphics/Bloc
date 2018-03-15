api - constraints
minHeight: aNumber
	"Set minimal height to be aNumber,
	aNumber must not be nil
	aNumber must not be infinite
	aNumber must be non-negative"
	
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Minimal height must not be nil' ].
		
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Minimal height must not be infinite' ].
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Minimal height must be non-negative' ].
	
	minHeight := aNumber