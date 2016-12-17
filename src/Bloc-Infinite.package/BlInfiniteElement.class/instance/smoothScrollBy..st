scrolling
smoothScrollBy: aPoint
	"Animate a scroll by the given amount of pixels along either axis"

	| dX dY |
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
	dX := aPoint x.
	dY := aPoint y.
	
	self layout canScrollHorizontally
		ifFalse: [ dX := 0 ].
	
	self layout canScrollVertically
		ifFalse: [ dY := 0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]