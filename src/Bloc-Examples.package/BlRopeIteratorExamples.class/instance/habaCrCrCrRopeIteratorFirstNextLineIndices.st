examples - haba,cr,cr,cr
habaCrCrCrRopeIteratorFirstNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self habaCrCrCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 1.
	self assert: end equals: 4.
	self assert: endDelimited equals: 5.
	self assert: anIterator hasNext. 
	
	^ anIterator