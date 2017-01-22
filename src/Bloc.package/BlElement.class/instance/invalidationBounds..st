geometry bounds
invalidationBounds: aBounds
	"I compute and load damaged area in my local coordinates that would be invalidated
	if #invalidate would be sent to me"
	<return: #BlBounds>

	^ (self effectBounds: aBounds) merge: self boundsInLocal