geometry bounds
invalidationBounds: aSpartaRectangle
	"I compute and load damaged area in my local coordinates that would be invalidated
	if #invalidate would be sent to me"
	<return: #SpartaRectangle>

	^ (self effectBounds: aSpartaRectangle) merge: self boundsInLocal