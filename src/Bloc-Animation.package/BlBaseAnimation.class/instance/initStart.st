private - running
initStart

	"new loop should start exactly when previous ends"
	startTime := self atLeastOneLoopDone
		ifTrue: [ self loopDoneTime ]
		ifFalse: [ self time now ].

	progress := 0.
	elapsedTime := 0 milliSeconds.
	isRunning := true.
	isStarted := true