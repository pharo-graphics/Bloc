private
saveOldPositions

	childrenController unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self childHolderOf: anElement.
		(anElementHolder position = self class noPosition and: [ anElementHolder isRemoved not ])
			ifTrue: [ self error: 'Element holder can not have undefined position unless it is removed' ].
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder saveOldPosition ] ]