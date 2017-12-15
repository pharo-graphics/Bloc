tests
testSubstraction

	| res |
	res := (BlInsets top: 1 right: 4 bottom: 3 left: 2) - 
			 (BlInsets top: 1 left: 2 bottom: 3 right: 4).
			
	self assert: res isEmpty