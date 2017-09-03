pulse
doStep
	| runningAnims |
	runningAnims := children select: [ :each | each isRunning ].
	runningAnims ifEmpty: [ ^ self].
	runningAnims do: [ :each | each pulse ].
	self onStep