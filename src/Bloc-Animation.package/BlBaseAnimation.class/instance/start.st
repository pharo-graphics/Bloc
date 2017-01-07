pulse
start
	self
		assert: [ self parent isNil ]
		description: [ 'A sub-animation has to be started from its parent' ].
	
	self
		assert: [ self isRunning not ]
		description: [ 'Animation can not be start multiple times without stop' ].
	
	"Animation manager request next pulse, so we are ok to start"
	self animationManager addAnimation: self.
	self initStart