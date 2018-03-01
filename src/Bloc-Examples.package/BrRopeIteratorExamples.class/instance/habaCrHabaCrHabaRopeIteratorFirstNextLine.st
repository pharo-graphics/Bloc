examples - haba,cr,haba,cr,haba
habaCrHabaCrHabaRopeIteratorFirstNextLine
	<gtExample>
	| nextLine anIterator |
	
	anIterator := self habaCrHabaCrHabaRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	nextLine := anIterator nextLine.

	self assert: nextLine collection equals: self haba.
	"we skipped one Cr"
	self assert: anIterator position equals: 2 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator