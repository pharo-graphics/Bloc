api - running
run

	self isStarted
		ifFalse: [ self start ].

	self isRunning
		ifFalse: [ ^ self ].

	self shouldStartNextLoop
		ifTrue: [ self startNextLoop ].

	self step.

	self shouldStop
		ifTrue: [ self stop ].

	"I am a sub-animation, so I am not registred is animation"
	self isSubAnimation
		ifTrue: [ ^ self ].

	self isRunning
		ifTrue: [ self enqueue ]