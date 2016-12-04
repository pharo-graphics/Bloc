private - positions
findMinMaxChildLayoutPositions
	<return: #Interval>
	
	| minPositionPreLayout maxPositionPreLayout |
	
	childrenManager hasChildren
		ifFalse: [ ^ self class noPosition to: self class noPosition ].

	minPositionPreLayout := Float infinity.
	maxPositionPreLayout := Float negativeInfinity.
	
	childrenManager childrenDo: [ :anElement | 
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aPosition |
			aPosition := anElementHolder layoutPosition.
			minPositionPreLayout := minPositionPreLayout min: aPosition.
			maxPositionPreLayout := maxPositionPreLayout max: aPosition ] ].
	^ minPositionPreLayout to: maxPositionPreLayout