accessing
effect: anEffect
	"Change my effect to a given one requesting draw area invalidations.
	anEffect must not be nil"
	
	self
		assert: [ anEffect isNotNil ]
		description: [ 'anEffect must not be nil' ].
	
	self flag: 'What should happen when we already have an effect?'.
	
	self invalidate.
	anEffect on: self.
	self effectProperty value: anEffect.
	self invalidate