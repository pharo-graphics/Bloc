scrolling
continueWhenFinishedSpline

	duration < splineDuration
		"Normal stop, no need to continue"
		ifFalse: [ ^ false ].
		
	startPosition := finalPosition.
	currentPosition := finalPosition.
	startVelocity := currentVelocity.
	deceleration := self decelerationFor: startVelocity.
	startTime := startTime + duration.
	self onEdgeReached.
	
	^ true