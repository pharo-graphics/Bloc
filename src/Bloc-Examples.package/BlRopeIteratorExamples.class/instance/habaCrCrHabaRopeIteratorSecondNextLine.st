examples - haba,cr,cr,haba
habaCrCrHabaRopeIteratorSecondNextLine
	<gtExample>
	| nextLine anIterator |

	anIterator := self habaCrCrHabaRopeIteratorFirstNextLine.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 3 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator