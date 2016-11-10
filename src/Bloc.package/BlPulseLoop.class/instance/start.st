accessing
start
	^ loopProcess
		ifNil: [ 
			session := Smalltalk session.
			loopProcess := self createLoopProcess.
			loopProcess resume ]