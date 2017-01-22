as yet unclassified
testCompareAddManyHandlers
	<expectedFailure> "addition is slow in our implementation"
 |ann reg t1 t2|

	ann := Announcer new.
	reg := BlHandlerRegistry new.
	
	t1 := [1000 timesRepeat: [ann subscribe: BlEvent do: [] ]]timeToRunWithoutGC.
	t2 := [1000 timesRepeat: [ reg add: (BlEventHandler on: BlEvent do:[]) ]] timeToRunWithoutGC.
	
	self assert: t1>t2