scrolling
runIfNecessaryOn: anInfiniteElement

	self hasJumpTarget
		ifTrue: [ 
			| aPosition |
			aPosition := jumpPosition.
			jumpPosition := NoPosition.
			anInfiniteElement jumpToPositionForSmoothScroller: aPosition.
			isChanged := false.
			^ self ].

	isChanged
		ifFalse: [ 
			consecutiveUpdates := 0.
			^ self	 ].
	
	self validate.
	interpolator
		ifNil: [ self hasDuration
			ifTrue: [ anInfiniteElement scrollFlinger
				smoothScrollBy: deltaX @ deltaY
				during: duration ]
			ifFalse: [ anInfiniteElement scrollFlinger
				smoothScrollBy: deltaX @ deltaY  ] ]
		ifNotNil: [ anInfiniteElement scrollFlinger
			smoothScrollBy: deltaX @ deltaY
			during: duration
			with: interpolator ].
	
	consecutiveUpdates := consecutiveUpdates + 1.
	consecutiveUpdates > 10
		"A new action is being set in every animation step. This looks like a bad implementation. Inform developer."
		ifTrue: [ 
			Notification signal: 'Smooth Scroll action is being updated too frequently. Make sure you are not changing it unless necessary' ].
	
	isChanged := false