private - positions
clearOldPositions

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder clearOldPosition ] ].
		
	recycler clearOldPositions