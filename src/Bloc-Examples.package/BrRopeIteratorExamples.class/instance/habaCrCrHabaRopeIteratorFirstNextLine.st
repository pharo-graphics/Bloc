examples - haba,cr,cr,haba
habaCrCrHabaRopeIteratorFirstNextLine
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrCrHabaRopeIterator.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 1 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator