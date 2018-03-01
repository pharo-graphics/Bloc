examples - hasNext
habaRopeEmptyIteratorHasNext
	<gtExample>
	| anIterator |

	anIterator := self habaRopeEmptyIterator.

	self assert: anIterator position isZero.
	self assert: anIterator hasNext not.

	^ anIterator