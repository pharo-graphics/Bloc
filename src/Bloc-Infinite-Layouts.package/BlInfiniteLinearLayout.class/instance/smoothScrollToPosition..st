scrolling
smoothScrollToPosition: aPosition
	| aSmoothScroller |
	
	aSmoothScroller := self defaultSmoothScroller.
	aSmoothScroller targetPosition: aPosition.
	self startSmoothScroll: aSmoothScroller