tests
testSum

	| res |
	res := (BlInsets top: 1 right: 4 bottom: 3 left: 2) + 
			 (BlInsets top: 1 left: 2 bottom: 3 right: 4).
			
	self assert: res top equals: 2.
	self assert: res left equals: 4.
	self assert: res bottom equals: 6.
	self assert: res right equals: 8.