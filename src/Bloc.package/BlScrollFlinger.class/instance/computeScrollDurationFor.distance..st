private - physics
computeScrollDurationFor: aVelocityPoint distance: aDeltaPoint
	<return: #Duration>

	| anAbsDx anAbsDy isHorizontal aVelocity aDelta aContainerSize aHalfContainerSize aDistanceRatio aDistance aDuration |
 
	anAbsDx := aDeltaPoint x abs.
	anAbsDy := aDeltaPoint y abs.
	isHorizontal := anAbsDx > anAbsDy.
	aVelocity := aVelocityPoint r. "sqrt(x*x + y*y)"
	aDelta := aDeltaPoint r. "sqrt(x*x + y*y)"
	aContainerSize := isHorizontal
		ifTrue: [ self scrollable width ]
		ifFalse: [ self scrollable height ].
	aHalfContainerSize := aContainerSize / 2.0.
	aDistanceRatio := (aDelta / aContainerSize) min: 1.0.
	aDistance := aHalfContainerSize + (aHalfContainerSize * (self distanceInfluenceForSnapDuration: aDistanceRatio)).
	
	aDuration := (aVelocity > 0)
		ifTrue: [ 4 * (1000.0 * (aDistance / aVelocity) abs) rounded ]
		ifFalse: [ 
			| anAbsDelta |
			anAbsDelta := isHorizontal
				ifTrue: [ anAbsDx ]
				ifFalse: [ anAbsDy ].
			(((anAbsDelta / aContainerSize) + 1) * 300) asInteger ].
	
	^ aDuration milliSeconds min: self maxScrollDuration