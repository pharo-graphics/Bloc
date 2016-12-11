private - invalidation
markKnownElementsInvalid
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			anElementHolder flags addUpdate.
			anElementHolder flags addInvalid ] ].
	
	self markItemDecorInsetsDirty.
	recycler markKnownElementsInvalid