as yet unclassified
testDelegate
	|p1 p2|
	p1 := BlObjectProperty on: nil named: #myProperty default: Association new.
	p2 := BlDelegateProperty on: nil named: #key delegateTo: p1.
	
	p2 value: #test.
	
	self assert: p2 value = #test description:'p1''s value should be equal to #test'.
	self assert: p1 value key = #test description:'the association''s key should be equal to #test'