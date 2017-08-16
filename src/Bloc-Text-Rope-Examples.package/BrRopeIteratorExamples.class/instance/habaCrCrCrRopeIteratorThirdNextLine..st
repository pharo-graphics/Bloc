examples - haba,cr,cr,cr
habaCrCrCrRopeIteratorThirdNextLine: anIterator
	<gtExample>
	<dependsOn: #habaCrCrCrRopeIteratorSecondNextLine:>
	| nextLine |
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 3 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator