private - invalidation
setDataSourceChangedAfterLayout
	
	"We already set that data source is changed"
	dataSourceChangedAfterLayout
		ifTrue: [ ^ self ].
		
	dataSourceChangedAfterLayout := true.
	childrenController unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self childHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder flagDataSourcePositionUnknown: true ] ].
	
	recycler setDataSourcePositionsAsUnknown