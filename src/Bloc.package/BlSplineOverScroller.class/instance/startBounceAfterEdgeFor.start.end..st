private - scrolling
startBounceAfterEdgeFor: aVelocity start: aStart end: anEnd

	deceleration := self decelerationFor: ( aVelocity isZero
		ifTrue: [ aStart - anEnd ]
		ifFalse: [ aVelocity ] ).
		
	self fitOnBounceCurveFor: aVelocity start: aStart end: anEnd.
	self onEdgeReached