weight
weight: aNumber
	"Set new weight value that defines how much space an element takes within parent's available space.
	aNumber must not be nil
	aNumber must be non negative
	aNumber must not be infinite"
	self
		assert: [ aNumber isNotNil ]
		description: [ 'Weight can not be nil' ].
		
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Weight must be non negative' ].
	
	self
		assert: [ aNumber < Float infinity ]
		description: [ 'Weight must not be infinite' ].

	weight := aNumber