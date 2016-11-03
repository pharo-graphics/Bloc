as yet unclassified
testBindingBidirectional
	|p1 p2|
	p1 := BlObjectProperty new.
	p2 := BlObjectProperty new.
	
	p1 bindOn: p2 bidirectional:true.
	p2 value: #test.
	
	self assert: p2 value = #test.
	self assert: p1 value = p2 value .
	
	p1 value: #test2.
	
	self assert: p1 value = #test2.
	self assert: p2 value = p1 value .
