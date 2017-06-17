tests
testSize
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray size) equals: 5.
	
	childrenArray := self fill: 0.
	self assert: (childrenArray size) equals: 0