examples - a,cr,b,cr,c
aCrbCrcRopeIteratorSecondNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrbCrcRopeIteratorFirstNextLineIndices.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 2 + self a size.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 3.
	self assert: end equals: 3.
	self assert: endDelimited equals: 4.
	self assert: anIterator hasNext. 
	
	^ anIterator