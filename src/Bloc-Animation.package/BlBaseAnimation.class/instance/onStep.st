action  handling
onStep
	self fireEvent: (BlAnimationStepEvent new progress: progress)