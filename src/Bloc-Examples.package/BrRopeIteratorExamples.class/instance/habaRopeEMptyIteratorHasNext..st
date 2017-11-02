examples - hasNext
habaRopeEMptyIteratorHasNext: anIterator
	<gtExample>
	<dependsOn: #habaRopeEmptyIterator:>
	
	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.

	^ anIterator