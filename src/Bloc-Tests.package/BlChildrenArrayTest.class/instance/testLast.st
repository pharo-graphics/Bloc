tests
testLast
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: (childrenArray last userData at: #index) equals: 5