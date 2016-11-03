pulse
stop
	self isRunning
		ifFalse: [ ^ self ].
	
	running := false.
	loopCount := 0.
	"if i have a parent, i am not registred in the animation manager"
	self parent ifNotNil: [ ^ self ].
	self animationManager removeAnimation: self.
	