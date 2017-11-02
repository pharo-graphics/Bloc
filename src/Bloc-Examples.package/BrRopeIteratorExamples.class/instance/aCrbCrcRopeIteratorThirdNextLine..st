examples - a,cr,b,cr,c
aCrbCrcRopeIteratorThirdNextLine: anIterator
	<gtExample>
	<dependsOn: #aCrbCrcRopeIteratorSecondNextLine:>
	| nextLine |

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self a size + self b size.

	nextLine := anIterator nextLine.

	self assert: nextLine collection equals: self c.
	self assert: anIterator position equals: 3 + self a size + self b size + self c size.
	self assert: anIterator hasNext not.

	^ anIterator