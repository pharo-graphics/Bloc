add/remove
addAnimation: anAnimation

	self
		assert: [ anAnimation isNotNil ]
		description: [ 'Animation must not be nil' ].

	self
		assert: [ (animations includes: anAnimation) not ]
		description: [ 'Animation must not exist' ].

	animations := animations copyWith: anAnimation.

	"we have to request a next pulse if "
	BlUniverse default isRunning
		ifTrue: [ BlUniverse default requestNextPulse ]