examples - hasNext
emptyRopeIteratorHasNext: anIterator
	<gtExample>
	<dependsOn: #emptyRopeIterator:>
	
	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.
	
	^ anIterator