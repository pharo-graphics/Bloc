api - testing
isOverScrolled
	"Returns whether the current Scroller is currently returning to a valid position.
	Valid bounds were provided by the ==#fling:==method.

	One should check this value before calling ==#startScroll== as the interpolation currently in progress
	to restore a valid position will then be stopped. The caller has to take into account the fact that the started scroll will start from an overscrolled position.
	
	I return true when the current position is overscrolled and in the process of interpolating back to a valid value"
	<return: #Boolean>

	^ (scrollerX isFinished not and: [ scrollerX isSpline not ])
		or: [ scrollerY isFinished not and: [ scrollerY isSpline not ] ]