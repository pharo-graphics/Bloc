scrolling
onScrollBy: aPoint
	| anInfiniteElement hadJumpTarget |
		
	anInfiniteElement := infiniteElement.
	(isRunning not or: [ targetPosition = NoPosition or: [ anInfiniteElement isNil ] ])
		ifTrue: [ self stop ].
	
	pendingInitialRun := false.
	targetElement ifNotNil: [ :anElement |
		(self childPositionOf: anElement) = targetPosition
			ifTrue: [ 
				self onTargetFound: anElement action: action.
				action runIfNecessaryOn: anInfiniteElement.
				self stop ] 
			"Passed over target position while smooth scrolling"
			ifFalse: [ targetElement := nil ] ].
	
	isRunning
		ifFalse: [ ^ self ].

	self onSeekTargetStep: aPoint action: action.
	hadJumpTarget := action hasJumpTarget.
	action runIfNecessaryOn: anInfiniteElement.
	hadJumpTarget
		ifTrue: [ 
			isRunning
				ifTrue: [ 
					pendingInitialRun := true.
					infiniteElement postSmoothScroller ]
				ifFalse: [
					"done" 
					self stop ] ]