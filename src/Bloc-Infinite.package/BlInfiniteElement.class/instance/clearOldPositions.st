private
clearOldPositions

	childrenController unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self childHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder clearOldPosition ] ].
		
	recycler clearOldPositions