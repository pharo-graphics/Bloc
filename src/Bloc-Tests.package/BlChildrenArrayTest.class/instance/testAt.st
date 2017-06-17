tests
testAt
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: ((childrenArray at: 1) userData at: #index) equals: 1.
	self assert: ((childrenArray at: 3) userData at: #index) equals: 3.
	self assert: ((childrenArray at: 5) userData at: #index) equals: 5.