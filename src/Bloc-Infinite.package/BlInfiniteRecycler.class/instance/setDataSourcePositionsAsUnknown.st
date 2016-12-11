invalidation
setDataSourcePositionsAsUnknown
	
	self cachedScrap do: [ :anElementHolder |
		anElementHolder flags addDataSourcePositionUnknown ]