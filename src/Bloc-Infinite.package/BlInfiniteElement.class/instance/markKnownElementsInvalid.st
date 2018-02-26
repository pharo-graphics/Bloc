private - invalidation
markKnownElementsInvalid
	"Mark all known elements as invalid. Used in response to a, the whole world might have changed data change event"

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			anElementHolder flags addUpdate.
			anElementHolder flags addInvalid ] ].
	
	self markItemDecorInsetsDirty.
	recycler markKnownElementsInvalid