tests
testIsEmpty
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: childrenArray isEmpty not.
	
	childrenArray := self fill: 0.
	self assert: childrenArray isEmpty.