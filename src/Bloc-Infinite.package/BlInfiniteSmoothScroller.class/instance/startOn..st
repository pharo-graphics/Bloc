scrolling
startOn: anInfiniteElement
	"Starts a smooth scroll for the given target position (set using targetPosition:).
	In each animation step, InfiniteElement will check for the target element and send either
	#onTargetFound or #onSeekTargetStep until SmoothScroller is stopped.
	Note that if InfiniteElement finds the target element, it will automatically stop the SmoothScroller.
	This does not mean that scroll will stop, it only means it will stop triggering SmoothScroller in each animation step"

	self
		assert: [ anInfiniteElement isNotNil ]
		description: [ 'Can not scroll nil element!' ].

	infiniteElement := anInfiniteElement.
	infiniteLayout := anInfiniteElement layout.
	
	(targetPosition isNil or: [ targetPosition = NoPosition ])
		ifTrue: [ self error: 'Invalid target position: ', targetPosition asString ].
	
	infiniteElement state targetScrollPosition: targetPosition.
	isRunning := true.
	pendingInitialRun := true.
	targetElement := self childAtPosition: targetPosition.
	self onStart.
	infiniteElement postScroller