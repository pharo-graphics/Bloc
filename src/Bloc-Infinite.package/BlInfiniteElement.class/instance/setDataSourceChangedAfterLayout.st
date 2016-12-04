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
	
	recycler setDataSourcePositionsAsUnknown