private - invalidation
markKnownElementsInvalid
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			anElementHolder flags addUpdate.
			anElementHolder flag addInvalid ] ].
	
	self markItemDecorInsetsDirty.
	recycler markKnownElementsInvalid