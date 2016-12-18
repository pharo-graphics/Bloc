scrolling
stopSmoothScroller
	"Ask current smooth scroller to stop scrolling"

	smoothScroller ifNotNil: [ :aScroller | aScroller stop ]