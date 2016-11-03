as yet unclassified
testBinding
	|p1 p2|
	p1 := BlObjectProperty new.
	p2 := BlObjectProperty new.
	
	p1 bindOn: p2.
	p2 value: #test.
	
	self assert: p2 value = #test.
	self assert: p1 value = p2 value 