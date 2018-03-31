private
runSmoothOn: aSmoothScroller with: aState
	| aDeltaPoint |

	"Can not scroll smoothly using nil scroller
	(which means that smooth scroll was not requested)"
	aSmoothScroller
		ifNil: [ ^ self ].
	
	"Can not scroll if smooth scroller is not yet initialized or not running"
	(aSmoothScroller isPendingInitialRun or: [
		aSmoothScroller isRunning not ])
			ifTrue: [ ^ self ].

	aDeltaPoint := (aState dX - aState overscrollX) @ (aState dY - aState overscrollY).	

	aSmoothScroller scrollBy: aDeltaPoint