testing
isOverScrolled

	^ (scrollerX isFinished not and: [ scrollerX isSpline not ])
		or: [ scrollerY isFinished not and: [ scrollerY isSpline not ] ]