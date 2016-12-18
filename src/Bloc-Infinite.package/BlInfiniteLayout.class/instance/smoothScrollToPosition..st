scrolling
smoothScrollToPosition: aPosition
	"Smooth scroll to the specified datasource position.
	To support smooth scrolling, override me, create your SmoothScroller instance
	and send #startSmoothScroll: with SmoothScroller as argument"

	^ self subclassResponsibility