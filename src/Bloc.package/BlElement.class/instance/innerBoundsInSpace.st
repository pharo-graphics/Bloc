geometry bounds
innerBoundsInSpace
	self flag: #needsCache.
	^ self localBoundsToGlobal:  self innerBounds