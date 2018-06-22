examples - a,cr
aCrRopeIteratorFirstNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrRopeIterator.
	
	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1.
	
	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: anIterator position equals: 3.
	self assert: start equals: 1.
	self assert: end equals: 1.
	self assert: endDelimited equals: 2.
	self assert: anIterator hasNext not. 
	
	^ anIterator