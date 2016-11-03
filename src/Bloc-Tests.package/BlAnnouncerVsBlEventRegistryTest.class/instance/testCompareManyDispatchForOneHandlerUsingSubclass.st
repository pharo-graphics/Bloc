as yet unclassified
testCompareManyDispatchForOneHandlerUsingSubclass
 |ann reg t1 t2 c1 c2 counter|
	c1 := c2 := 0.
	counter := 100000.
	ann := Announcer new.
	reg := BlHandlerRegistry new.
	
	ann subscribe: BlEvent do: [c1 := c1+1] .
	reg add: (BlEventHandler on: BlEvent do:[c2 := c2+1]).
	
	t1 := [counter timesRepeat: [ann announce: BlClickEvent new]] timeToRunWithoutGC.
	t2 := [counter timesRepeat:[reg dispatchEvent: BlClickEvent new]] timeToRunWithoutGC.
	
	self assert: t1>t2.
	self assert: c1 = counter.
	self assert: c2 = counter