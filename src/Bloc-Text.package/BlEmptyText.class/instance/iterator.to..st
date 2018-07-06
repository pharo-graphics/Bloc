text - enumeration
iterator: aStartIndex to: anEndIndex
	<return: #BlTextIterator>
	
	self
		assert: [ aStartIndex isZero and: [ aStartIndex = anEndIndex ] ]
		description: [ 'Start end end indices for empty iterator must be 0' ].
	
	^ BlEmptyTextIterator new