pulse
stop
	
	self
		assert: [ self isRunning ]
		description: [ 'Animation is not running' ].

	running := false.
	loopCount := 0.

	"I am a sub-animation, so I am not registred in the animation manager"
	self isSubAnimation
		ifTrue: [ ^ self ].

	self animationManager removeAnimation: self