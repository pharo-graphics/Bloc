recycling
recycleAndRemoveCachedElements
	
	cachedScrap size to: 1 do: [ :index | self recycleCachedAt: index ].
	cachedScrap removeAll