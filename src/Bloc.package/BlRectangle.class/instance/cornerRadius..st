accessing
cornerRadius: aNumber
	"Change the radii of all corners to a given number.
	aNumber must not be nil.
	aNumber must be non-negative"

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Corner radius must be non-negative!' ].
	
	self cornerRadii: (BlCornerRadii radius: aNumber)