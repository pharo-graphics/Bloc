private - children
scrapOrRecycleChild: anElement at: anIndex
	| anElementHolder |
	
	anElementHolder := self childHolderOf: anElement.
	anElementHolder shouldIgnore
		ifTrue: [ ^ self ].

	(anElementHolder isInvalid and: [
		anElementHolder isRemoved not
			and: [ self dataSource hasStableIds not ] ])
		ifTrue: [ 
			self removeChildAt: anIndex.
			self recycler recycleElementHolder: anElementHolder ]
		ifFalse: [
			self detachChildAt: anIndex.
			self recycler scrapElement: anElement.
			self infoHolderDetached: anElementHolder ]