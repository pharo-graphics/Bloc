tests
testFirst
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: (childrenArray first userData at: #index) equals: 1.