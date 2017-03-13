accessing
extent: aPoint
	"The argument has to be a Point of numbers (integer or float).
	Do not try to provide a fraction as x or y of the point!
	aPoint must not be nil
	aPoint must be positive"

	self
		assert: [ aPoint x >= 0 and: [ aPoint y >= 0 ] ]
		description: [ 'Geometry extent must be non-negative!' ].

	extent := aPoint