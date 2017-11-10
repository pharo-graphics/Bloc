accessing
strategy: aScalableStrategy

	self
		assert: [ aScalableStrategy isNotNil ]
		description: [ 'Scalable strategy must not be nil' ].

	strategy := aScalableStrategy