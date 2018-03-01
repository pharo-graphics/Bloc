examples - hasNext
aCrRopeIteratorHasNext
	<gtExample>
	| anIterator | 
	anIterator := self aCrRopeIterator.
	
	self assert: anIterator position equals: 1.
	self assert: anIterator hasNext.
	
	^ anIterator