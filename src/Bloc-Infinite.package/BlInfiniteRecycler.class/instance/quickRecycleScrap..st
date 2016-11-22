recycling
quickRecycleScrap: anElement
	"Used as a fast path for unscrapping and recycling a an element during a bulk operation.
	The sender must send #clearScrap when it's done to update the recycler's internal bookkeeping.
	anElement must not be nil"
	| anElementHolder |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not recycle nil element' ].

	anElementHolder := self controller childHolderOf: anElement.
	anElementHolder detachRecycler.
	self recycleElementHolder: anElementHolder