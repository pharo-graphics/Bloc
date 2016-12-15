scrolling
continueWhenFinishedBallistic

	startTime := startTime + duration.
	"yes, we need to invert positions to spring back"
	self startSpringbackFor: 0 start: finalPosition end: startPosition.

	^ true