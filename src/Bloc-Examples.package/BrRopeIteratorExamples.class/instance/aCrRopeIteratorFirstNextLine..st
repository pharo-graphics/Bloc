examples - a,cr
aCrRopeIteratorFirstNextLine: anIterator
	<gtExample>
	<dependsOn: #aCrRopeIterator:>
	| nextLine |
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self a.
	self assert: anIterator position equals: 1 + self a size.
	self assert: anIterator hasNext.
	
	^ anIterator