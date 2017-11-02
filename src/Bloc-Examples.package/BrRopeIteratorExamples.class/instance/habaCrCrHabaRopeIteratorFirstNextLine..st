examples - haba,cr,cr,haba
habaCrCrHabaRopeIteratorFirstNextLine: anIterator
	<gtExample>
	<dependsOn: #habaCrCrHabaRopeIterator:>
	| nextLine |

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 1 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator