as yet unclassified
testCompareAddManyHandlers
 |ann reg t1 t2|

	ann := Announcer new.
	reg := BlHandlerRegistry new.
	
	t1 := [100000 timesRepeat: [ann subscribe: BlEvent do: [] ]]timeToRunWithoutGC.
	t2 := [100000 timesRepeat: [ reg add: (BlEventHandler on: BlEvent do:[]) ]] timeToRunWithoutGC.
	
	self assert: t1>t2