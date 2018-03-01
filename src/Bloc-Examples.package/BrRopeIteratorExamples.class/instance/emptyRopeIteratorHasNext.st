examples - hasNext
emptyRopeIteratorHasNext
	<gtExample>
	| anIterator |
	
	anIterator := self emptyRopeIterator.
	
	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.
	
	^ anIterator