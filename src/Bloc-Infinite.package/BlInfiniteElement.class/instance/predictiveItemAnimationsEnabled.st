private - testing
predictiveItemAnimationsEnabled
	<return: #Boolean>
	^ itemAnimator supportsAnimations
		and: [ layout supportsPredictiveItemAnimations ]