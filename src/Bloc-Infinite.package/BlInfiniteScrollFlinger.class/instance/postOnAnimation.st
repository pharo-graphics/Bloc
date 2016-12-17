scheduling
postOnAnimation
	
	eatRunOnAnimationRequest
		ifTrue: [ reSchedulePostAnimationCallback := true ]
		ifFalse: [ 
			infiniteElement unpostOnAnimation: self.
			infiniteElement postOnAnimation: self ]