recycling
recycleCachedAt: aCachedIndex
	| anElementHolder |
	anElementHolder := cachedScrap at: aCachedIndex.
	
	cachedScrap removeAt: aCachedIndex.

	" 
            addViewHolderToRecycledViewPool(viewHolder);
            mCachedViews.remove(cachedViewIndex);"