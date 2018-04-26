api - running
run

	self isRunning
		ifFalse: [ ^ self ].

	"time didn't come yet for me to run"
	(previousRunTime isNotNil and: [ self time now < (previousRunTime + self delay) ])
		ifTrue: [ ^ self enqueue ].
	
	self onRun.
	previousRunTime := previousRunTime
		ifNil: [ self time now ]
		ifNotNil: [ previousRunTime + self delay ].
	
	"it is possible that we stop the task in #onRun"
	self isRunning
		ifTrue: [ self enqueue ]