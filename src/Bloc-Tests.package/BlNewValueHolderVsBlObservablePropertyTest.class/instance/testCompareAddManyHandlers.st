as yet unclassified
testCompareAddManyHandlers
 |vh prop t1 t2|

	vh := NewValueHolder new.
	prop := BlObjectProperty new.
	
	t1 := [100000 timesRepeat: [vh whenChangedDo: [] ]] timeToRunWithoutGC.
	t2 := [100000 timesRepeat: [ prop onChangedDo: [] ]] timeToRunWithoutGC.
	
	self assert: t1>t2