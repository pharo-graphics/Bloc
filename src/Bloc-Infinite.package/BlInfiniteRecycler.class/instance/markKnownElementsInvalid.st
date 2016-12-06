invalidation
markKnownElementsInvalid

	self controller hasStableIds
		ifTrue: [ 
			self cachedScrap do: [ :anElementHolder |
				anElementHolder flags addUpdate; addInvalid.
				anElementHolder addEmptyPayload ] ]
		"we cannot re-use cached elements in this case. Recycle them all"
		ifFalse: [ 
			self recycleAndRemoveCachedElements ]