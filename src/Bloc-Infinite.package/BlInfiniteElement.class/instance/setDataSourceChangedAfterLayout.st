private - invalidation
setDataSourceChangedAfterLayout
	
	"We already set that data source is changed"
	dataSourceChangedAfterLayout
		ifTrue: [ ^ self ].
		
	dataSourceChangedAfterLayout := true.
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder flags addDataSourcePositionUnknown ] ].
	
	recycler setDataSourcePositionsAsUnknown.
	"immediately mark all elements as invalid, so prefetched ones can be
	differentiated from elements bound to previous data set - both in children, and cache"
	self markKnownElementsInvalid