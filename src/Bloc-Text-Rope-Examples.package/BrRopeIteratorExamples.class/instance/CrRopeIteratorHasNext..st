examples - hasNext
CrRopeIteratorHasNext: anIterator
	<gtExample>
	<dependsOn: #aCrRopeIterator:>
	
	self assert: anIterator position = 1.
	self assert: anIterator hasNext.
	
	^ anIterator