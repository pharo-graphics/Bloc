scrolling
computeOffsetScroll
	| aTime anElapsedTime aDuration |

	aTime := DateAndTime millisecondClockValue.
	
	"Any scroller can be used for time, since they were started
	together in scroll mode. We use X here."
	anElapsedTime := aTime - scrollerX startTime.
	aDuration := scrollerX duration.
	
	anElapsedTime < aDuration
		ifTrue: [ 
			| anInterpolatedTime |	
			anInterpolatedTime := interpolator interpolate: (anElapsedTime / aDuration) asFloat.
			scrollerX updateScroll: anInterpolatedTime.
			scrollerY updateScroll: anInterpolatedTime ]
		ifFalse: [ self finish ]