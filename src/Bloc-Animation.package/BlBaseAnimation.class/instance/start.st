pulse
start
	self assert: self parent isNil description: 'A sub-animation has to be started from its parent'.
	self isRunning
		ifTrue: [ self stop ].
	self initStart.
	self animationManager addAnimation: self.
	