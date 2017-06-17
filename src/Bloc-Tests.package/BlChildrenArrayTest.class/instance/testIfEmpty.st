tests
testIfEmpty
	| childrenArray |

	childrenArray := self fill: 5.
	self assert: (childrenArray ifEmpty: [ #empty ]) equals: childrenArray.
	
	childrenArray := self fill: 0.
	self assert: (childrenArray ifEmpty: [ #empty ]) equals: #empty