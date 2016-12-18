physics
updateActionForInterimTarget: aScrollerAction
	"When the target scroll position is not a child of the InfiniteElement,
	I calculates a direction vector towards that child and trigger a smooth scroll"
	| aScrollVector aTime |
	
	aScrollVector := self computeScrollVectorForPosition: self targetPosition.
	(aScrollVector isNil or: [ aScrollVector x isZero and: [ aScrollVector y isZero ] ])
		ifTrue: [ 
			aScrollerAction jumpTo: self targetPosition.
			self stop.
			^ self ].
		
	aScrollVector := aScrollVector normalized.
	targetVector := aScrollVector.
	
	interimTarget := (self targetSeekScrollDistance * aScrollVector x) @ (self targetSeekScrollDistance * aScrollVector y).
	aTime := self calculateTimeForScrolling: self targetSeekScrollDistance.
	aScrollerAction
		update: interimTarget * self targetSeekExtraScrollRatio
		duration: aTime * self targetSeekExtraScrollRatio
		interpolator: linearInterpolator