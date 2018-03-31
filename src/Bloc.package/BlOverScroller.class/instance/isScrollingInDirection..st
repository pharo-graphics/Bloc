testing
isScrollingInDirection: aVectorPoint
	| aDeltaX aDeltaY |
	
	aDeltaX := scrollerX finalPosition - scrollerX startPosition.
	aDeltaY := scrollerY finalPosition - scrollerY startPosition.
	
	^ self isFinished not and: [
		aVectorPoint x sign = aDeltaX sign and: [ 
			aVectorPoint y sign = aDeltaY sign ] ]