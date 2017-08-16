examples - haba,cr,cr,cr
habaCrCrCrRopeIteratorSecondNextLine: anIterator
	<gtExample>
	<dependsOn: #habaCrCrCrRopeIteratorFirstNextLine:>
	| nextLine |
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 2 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator