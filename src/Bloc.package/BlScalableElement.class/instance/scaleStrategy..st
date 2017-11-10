accessing
scaleStrategy: aBlScalableStrategy
	"Set scale strategy used to compute scaling factor of the content element.
	Note: I request layout update"
	self
		assert: [ aBlScalableStrategy isNotNil ]
		description: [ 'Scalable strategy must not be nil' ].
		
	scaleStrategy := aBlScalableStrategy.
	self requestLayout