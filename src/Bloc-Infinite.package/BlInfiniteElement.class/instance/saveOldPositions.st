private - positions
saveOldPositions

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder position = NoPosition and: [ anElementHolder isRemoved not ])
			ifTrue: [ self error: 'Element holder can not have undefined position unless it is removed' ].
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder saveOldPosition ] ]