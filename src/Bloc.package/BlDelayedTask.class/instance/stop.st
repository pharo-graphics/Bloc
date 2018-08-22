api - running
stop
	"Stop the task by dequeuing it"
	(element isNotNil and: [ self isRunning ])
		ifTrue: [ self dequeue ].

	isRunning := false.
	startTime := nil