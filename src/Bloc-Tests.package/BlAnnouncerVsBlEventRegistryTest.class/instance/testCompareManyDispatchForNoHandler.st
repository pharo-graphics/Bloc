as yet unclassified
testCompareManyDispatchForNoHandler
 |ann reg t1 t2 counter|
	
	counter := 1000000.
	ann := Announcer new.
	reg := BlHandlerRegistry new.
	
	t1 := [counter timesRepeat: [ann announce: BlEvent new]] timeToRunWithoutGC.
	t2 := [counter timesRepeat:[reg dispatchEvent: BlEvent new]] timeToRunWithoutGC.
	
	self assert: t1>t2.