examples - a,cr,b,cr,c
aCrbCrcRopeIteratorFirstNextLine: anIterator
	<gtExample>
	<dependsOn: #aCrbCrcRopeIterator:>
	| nextLine |
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self a.
	self assert: anIterator position equals: 1 + self a size + 1. "last one since we skip new line symbol"
	self assert: anIterator hasNext.
	
	^ anIterator