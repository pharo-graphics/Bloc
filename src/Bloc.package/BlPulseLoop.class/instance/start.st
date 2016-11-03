loop process
start
	^ loopProcess
		ifNil: [ loopProcess := self createLoopProcess.
			loopProcess resume ]