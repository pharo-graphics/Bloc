api - scrolling
smoothScrollBy: aDeltaPoint during: aDuration with: anInterpolator

	aDuration isNumber
		ifTrue: [ ContextStackSignal emit ].

	interpolator ~~ anInterpolator
		"Interpolator changes, need to re-create a scroller"
		ifTrue: [ 
			interpolator := anInterpolator.
			scroller := self createScrollerFor: interpolator ].
	
	self beSettling.
	lastFlingX := 0.
	lastFlingY := 0.
	scroller startScrollAt: 0@0 by: aDeltaPoint during: aDuration.
	self postOnAnimation