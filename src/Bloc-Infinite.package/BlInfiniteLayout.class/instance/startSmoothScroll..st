scrolling
startSmoothScroll: aSmoothScroller
	"Starts a smooth scroll using the provided SmoothScroller.
	Calling me will cancel any previous smooth scroll request"

	(smoothScroller isNotNil and: [
		smoothScroller ~= aSmoothScroller and: [
			smoothScroller isRunning ] ])
		ifTrue: [ smoothScroller stop ].
	
	smoothScroller := aSmoothScroller.
	smoothScroller startOn: infiniteElement