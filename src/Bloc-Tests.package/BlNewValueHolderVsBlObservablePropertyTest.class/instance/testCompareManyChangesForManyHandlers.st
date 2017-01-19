tests
testCompareManyChangesForManyHandlers
 |vh prop t1 t2 c1 c2 counter|
	c1 := c2 := 0.
	counter := 5000.
	vh := NewValueHolder new.
	prop := BlObjectProperty new.
	
	counter timesRepeat: [vh whenChangedDo: [c1 := c1+1] ].
	counter timesRepeat: [ prop onChangedDo:[c2 := c2+1] ].
	
	t1 := [counter timesRepeat: [vh value: Object new]] timeToRunWithoutGC.
	t2 := [counter timesRepeat:[prop value: Object new]] timeToRunWithoutGC.
	
	self assert: t1>t2.
	self assert: c1 = counter squared.
	self assert: c2 = counter squared