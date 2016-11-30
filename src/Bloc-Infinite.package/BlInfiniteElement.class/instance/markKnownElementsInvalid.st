private - invalidation
markKnownElementsInvalid
	
	childrenController unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self childHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			anElementHolder flagUpdate: true.
			anElementHolder flagInvalid: true ] ].
	
	self markItemDecorInsetsDirty.
	recycler markKnownElementsInvalid