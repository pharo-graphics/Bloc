tests
testSecond
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray second userData at: #index) equals: 2