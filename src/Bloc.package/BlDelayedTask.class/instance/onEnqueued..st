hooks
onEnqueued: aBlSpace
	super onEnqueued: aBlSpace.

	self time: aBlSpace time.
	
	"start time of the very first time when we are enqueued"
	startTime
		ifNil: [ startTime := self time now ]