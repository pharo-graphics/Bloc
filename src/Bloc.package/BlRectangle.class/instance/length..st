accessing
length: aNumber
	"Transform me to a square with a given side length.
	aNumber must not be nil.
	aNumber must be non-negative"

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Side length must be non-negative' ].

	self extent: aNumber asPoint