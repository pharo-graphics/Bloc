scrolling - hooks
onSmoothScrollerStopped: aSmoothScroller
	"Is sent when smooth scroller stop scrolling"

	smoothScroller == aSmoothScroller
		ifTrue: [ smoothScroller := nil ]