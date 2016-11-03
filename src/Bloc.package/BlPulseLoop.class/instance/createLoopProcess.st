loop process
createLoopProcess
	^ self createLoopTask newProcess
		priority: BlUniverse default mainLoopPriority;
		name: self processId;
		yourself