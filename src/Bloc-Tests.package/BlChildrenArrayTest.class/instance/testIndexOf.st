tests
testIndexOf
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray indexOf: (childrenArray at: 1)) equals: 1.
	self assert: (childrenArray indexOf: (childrenArray at: 5)) equals: 5.
	self assert: (childrenArray indexOf: (BlElement new)) equals: 0.