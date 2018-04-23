pulse
doStep
	| runningAnims |
	runningAnims := animations select: [ :each | each isRunning ].
	runningAnims ifEmpty: [ ^ self].
	runningAnims do: [ :each | each run ].
	self onStep