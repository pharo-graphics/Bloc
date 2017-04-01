private - commands
offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and: [ anElementHolder position >= aStartPosition ])
			ifTrue: [ 
				anElementHolder offsetPositionBy: anItemCount applyToPreLayout: false.
				state structureChanged: true ] ].
	
	recycler offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount.
	self requestLayout