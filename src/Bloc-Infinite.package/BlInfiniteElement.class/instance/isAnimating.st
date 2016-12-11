testing
isAnimating
	"Return true if InfiniteElement is currently running some animations, false otherwise"
	<return: #Boolean>

	^ itemAnimator supportsAnimations
		and: [ itemAnimator isRunning ]