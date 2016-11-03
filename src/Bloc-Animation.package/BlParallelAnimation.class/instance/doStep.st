pulse
doStep
	| runningAnims |
	runningAnims := children select: [ :each | each isRunning ].
	runningAnims ifEmpty: [ ^ self stop ].
	runningAnims do: [ :each | each pulse ].