scrolling
stop

	isRunning
		ifFalse: [ ^ self ].
	
	self onStop.
	infiniteElement state targetPosition: BlInfiniteElement noPosition.
	targetElement := nil.
	targetPosition :=  BlInfiniteElement noPosition.
	pendingInitialRun := false.
	isRunning := false.
	
	"trigger a cleanup"
	infiniteLayout onSmoothScrollerStopped: self.
	
	"clear references to avoid any potential leak by a custom smooth scroller"
	infiniteLayout := nil.
	infiniteElement := nil