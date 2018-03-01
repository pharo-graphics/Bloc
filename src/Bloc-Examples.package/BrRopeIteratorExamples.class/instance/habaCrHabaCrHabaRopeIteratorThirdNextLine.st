examples - haba,cr,haba,cr,haba
habaCrHabaCrHabaRopeIteratorThirdNextLine
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrHabaCrHabaRopeIteratorSecondNextLine.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + (self haba size * 2).
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection equals: self haba.
	self assert: anIterator position equals: 3 + (self haba size * 3).
	self assert: anIterator hasNext not.
	
	^ anIterator