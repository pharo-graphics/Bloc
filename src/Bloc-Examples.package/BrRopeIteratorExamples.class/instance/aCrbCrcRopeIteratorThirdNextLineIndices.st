examples - a,cr,b,cr,c
aCrbCrcRopeIteratorThirdNextLineIndices
	<gtExample>
	| anIterator start end endDelimited |
	
	anIterator := self aCrbCrcRopeIteratorSecondNextLineIndices.

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 3 + self a size + self b size.

	anIterator nextLineIndicesDo: [ :aStart :anEnd :anEndDelimited | 
		start := aStart.
		end := anEnd.
		endDelimited := anEndDelimited ].
	
	self assert: start equals: 5.
	self assert: end equals: 5.
	self assert: endDelimited equals: 5.
	self assert: anIterator hasNext not. 

	^ anIterator