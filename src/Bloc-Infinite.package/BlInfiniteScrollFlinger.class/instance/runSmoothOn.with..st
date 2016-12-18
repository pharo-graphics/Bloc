running
runSmoothOn: aSmoothScroller with: aState
	| anItemCount aDeltaPoint |
		
	"Can not scroll smoothly using nil scroller
	(which means that smooth scroll was not requested"
	aSmoothScroller
		ifNil: [ ^ self ].
	
	"Can not scroll if smooth scroller is not yet initialized or not running"
	(aSmoothScroller isPendingInitialRun or: [
		aSmoothScroller isRunning not ])
			ifTrue: [ ^ self ].
	
	anItemCount := infiniteElement state itemCount.
	
	"If there are no items in datasource but smooth scroll is running, we need to stop it"
	anItemCount isZero
		ifTrue: [
			aSmoothScroller stop.
			^ self ].
		
	aSmoothScroller targetPosition > anItemCount
		"requested target position is greater that item count, scroll to the last item instead"
		ifTrue: [ aSmoothScroller targetPosition: anItemCount ].
	
	aDeltaPoint := (aState dX - aState overscrollX) @ (aState dY - aState overscrollY).
	aSmoothScroller onScrollBy: aDeltaPoint