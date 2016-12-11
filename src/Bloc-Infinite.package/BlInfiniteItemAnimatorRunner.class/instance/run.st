running
run
	itemAnimator supportsAnimations
		ifTrue: [ itemAnimator runPendingAnimations ].
	isPosted := false