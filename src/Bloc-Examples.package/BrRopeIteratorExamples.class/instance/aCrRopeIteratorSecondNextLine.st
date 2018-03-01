examples - a,cr
aCrRopeIteratorSecondNextLine
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self aCrRopeIteratorFirstNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self a size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 2 + self a size.
	self assert: anIterator hasNext not.
	
	^ anIterator