loop process
stop
	loopProcess
		ifNotNil: [ | tmp |
			tmp := loopProcess.
			loopProcess := nil.
			tmp terminate ].