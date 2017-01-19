tests
testCompareAddManyHandlers
	<expectedFailure> "addition is slow in our implementation"
 	|vh prop t1 t2|

	vh := NewValueHolder new.
	prop := BlObjectProperty new.
	
	t1 := [1000 timesRepeat: [vh whenChangedDo: [] ]] timeToRunWithoutGC.
	t2 := [1000 timesRepeat: [ prop onChangedDo: [] ]] timeToRunWithoutGC.
	
	self assert: t1>t2