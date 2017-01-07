add/remove
removeAnimation: anAnimation
	
	self
		assert: [ anAnimation isNotNil ]
		description: [ 'Animation must not be nil' ].

	self
		assert: [ animations includes: anAnimation ]
		description: [ 'Animation must exist' ].
	
	animations := animations copyWithout: anAnimation.
	"When animation is removed there is no need to request a next pulse,
	because the state is already committed on last animation step"