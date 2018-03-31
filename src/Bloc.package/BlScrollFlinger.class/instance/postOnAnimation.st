scheduling
postOnAnimation

	self
		assert: [ scrollable isNotNil ]
		description: [ 'Can not post on animation if I am not attached to a scrollable' ].

	eatRunOnAnimationRequest
		ifTrue: [ reSchedulePostAnimationCallback := true ]
		ifFalse: [ 
			(BlUniverse default animationManager includesAnimation: self)
				ifTrue: [ BlUniverse default animationManager removeAnimation: self ].
			BlUniverse default animationManager addAnimation: self. ]