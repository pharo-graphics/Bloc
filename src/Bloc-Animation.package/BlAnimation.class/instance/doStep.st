pulse
doStep
	self applyValue: (self valueForStep: (self computeDelta: progress)).
	self onStep