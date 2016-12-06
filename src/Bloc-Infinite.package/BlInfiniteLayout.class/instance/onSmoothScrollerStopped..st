scrolling - hooks
onSmoothScrollerStopped: aSmoothScroller
	"Is sent when smooth scrolled stop scrolling"

	smoothScroller == aSmoothScroller
		ifTrue: [ smoothScroller := nil ]