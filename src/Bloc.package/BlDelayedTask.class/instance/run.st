api - running
run
	self isRunning
		ifFalse: [ ^ self ].
	
	"time didn't come yet for me to run"
	(self time now < (startTime + self delay))
		ifTrue: [ ^ self enqueue ].
	
	self onRun.
	self stop