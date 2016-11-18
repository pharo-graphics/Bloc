accessing - properties
updateCacheSize
	"Update cache size based on requested cache size and various
	additional properties such as item prefetching.
	Return true if cached size value changed, false otherwise"
	<return: #Boolean>
	| extraCache index oldCachedSize |
	
	oldCachedSize := cacheSize.
	
	extraCache := self controller isItemPrefetchEnabled
		ifTrue: [ self controller itemPrefetchCount ]
		ifFalse: [ 0 ].

	cacheSize := requestedCacheSize + extraCache.

	index := cachedScrap size.
	
	[ index >= 1 and: [ cachedScrap size >= cacheSize ] ] whileTrue: [ 
		self recycleCachedAt: index.
		index := index - 1 ].
	
	^ oldCachedSize ~= cacheSize