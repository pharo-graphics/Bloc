recycling
recycleCachedAt: anIndex
	"Recycles a cached element and removes it from the list. Elements are added to cache
	if and only if they are recyclable, I do not check it again."
	| anElementHolder |
	
	anElementHolder := cachedScrap at: anIndex.

	self addHolderToRecyclerPool: anElementHolder.
	cachedScrap removeAt: anIndex