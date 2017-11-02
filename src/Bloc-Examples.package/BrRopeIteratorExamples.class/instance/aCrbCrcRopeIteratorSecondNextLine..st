examples - a,cr,b,cr,c
aCrbCrcRopeIteratorSecondNextLine: anIterator
	<gtExample>
	<dependsOn: #aCrbCrcRopeIteratorFirstNextLine:>
	| nextLine |
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self a size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self b.
	self assert: anIterator position equals: 2 + self a size + self b size + 1.
	self assert: anIterator hasNext.
	
	^ anIterator