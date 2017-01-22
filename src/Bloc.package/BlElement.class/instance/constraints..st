accessing
constraints: aLayoutConstraints
	"Set new layout constraints and request layout update.
	aLayoutConstraints must not be nil"
	
	self
		assert: [ aLayoutConstraints isNotNil]
		description: [ 'Constraints must not be nil' ].

	constraints := aLayoutConstraints.
	self requestLayout