examples - haba,cr,cr,cr
habaCrCrCrRopeIteratorSecondNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIteratorFirstNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self haba size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 5.
	self assert: end equals: 5.
	self assert: endDelimited equals: 6.
	self assert: anIterator hasNext.
	
	^ anIterator