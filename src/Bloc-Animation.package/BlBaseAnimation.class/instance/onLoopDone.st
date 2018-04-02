hooks
onLoopDone
	"Is sent right after a current loop is done"

	loopDoneTime := self delayedStartTime + self duration.
	loopCount := loopCount + 1.

	self notifyLoopDone