examples - haba,cr,cr,cr
habaCrCrCrRopeIteratorThirdNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIteratorSecondNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self haba size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 6.
	self assert: end equals: 6.
	self assert: endDelimited equals: 7.
	self assert: anIterator hasNext not.
	
	^ anIterator