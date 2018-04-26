scrolling
smoothScrollBy: aPoint
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifFalse: [ dX := 0 ].
	
	self canScrollVertically
		ifFalse: [ dY := 0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]